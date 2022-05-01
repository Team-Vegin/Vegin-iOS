//
//  HomeService.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/02.
//

import Foundation
import Moya

enum HomeService {
    case requestStartMission(missionID: Int)
}

extension HomeService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .requestStartMission:
            return "/mission"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestStartMission:
            return .post
        }
    }
    
    var task: Task {
        switch self {
            
        /// 미션 시작/중단하기
        case .requestStartMission(let missionID):
            let body: [String : Any] = [
                "missionId" : missionID
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaults.Keys.AccessToken) ?? ""
        
        let header = [
            "Content-Type": "application/json",
            "accessToken": accessToken
        ]
        return header
    }
}

