//
//  MyPageService.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/15.
//

import Foundation
import Moya

enum MyPageService {
    case getMypageInfo
}

extension MyPageService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getMypageInfo:
            return "/mypage"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMypageInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        /// 마이페이지 조회
        case .getMypageInfo:
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
