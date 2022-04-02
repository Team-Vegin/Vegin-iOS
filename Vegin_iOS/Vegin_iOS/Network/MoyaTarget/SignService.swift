//
//  SignService.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/01.
//

import Foundation
import Moya

enum SignService {
    case requestSignIn(email: String, pw: String)
}

extension SignService: BaseTargetType {
    var path: String {
        switch self {
        case .requestSignIn:
            return "/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestSignIn:
            return .post
        }
    }
    
    var task: Task {
        switch self {
            
        /// 로그인
        case .requestSignIn(let email, let pw):
            let body: [String : Any] = [
                "email" : email,
                "password" : pw
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        }
    }
}
