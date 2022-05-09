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
    case getMissionListStatus
    case selectCharacter(characterID: Int)
}

extension HomeService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .requestStartMission, .getMissionListStatus:
            return "/mission"
        case .selectCharacter:
            return "/mission/character/select"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestStartMission, .selectCharacter:
            return .post
        case .getMissionListStatus:
            return .get
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
            
            /// 캐릭터 선택하기
        case .selectCharacter(let characterID):
            let body: [String : Any] = [
                "characterId" : characterID
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
            
            /// 미션 리스트 현황 조회
        case .getMissionListStatus:
            return .requestPlain
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

