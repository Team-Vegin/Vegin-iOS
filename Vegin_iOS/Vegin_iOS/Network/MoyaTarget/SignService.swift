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
    case requestSignUp(email: String, pw: String, nickname: String, orientation: String)
    case checkEmailDuplicate(email: String)
    case checkNickNameDuplicate(nickname: String)
}

extension SignService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .requestSignIn:
            return "/auth/login"
        case .requestSignUp:
            return "/auth/signup"
        case .checkEmailDuplicate:
            return "/auth/duplication-check/email"
        case .checkNickNameDuplicate:
            return "/auth/duplication-check/nickname"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestSignIn, .requestSignUp, .checkEmailDuplicate, .checkNickNameDuplicate:
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
            
        /// 회원가입
        case .requestSignUp(let email, let pw, let nickname, let orientation):
            let body: [String : Any] = [
                "email" : email,
                "password" : pw,
                "nickname" : nickname,
                "orientation" : orientation
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
            
        /// 이메일 중복 체크
        case .checkEmailDuplicate(let email):
            let body: [String : Any] = [
                "email" : email
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
            
        /// 닉네임 중복 체크
        case .checkNickNameDuplicate(let nickname):
            let body: [String : Any] = [
                "nickname" : nickname
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let header = [
            "Content-Type": "application/json"
        ]
        return header
    }
}
