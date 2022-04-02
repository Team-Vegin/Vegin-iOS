//
//  BaseTargetType.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/30.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var headers: [String : String]? {
        if let accessToken = UserDefaults.standard.value(forKey: UserDefaults.Keys.AccessToken) {
            let header = [
                "Content-Type": "application/json",
                "accessToken": "\(accessToken)"
            ]
            return header
        } else {
            let header = [
                "Content-Type": "application/json"
            ]
            return header
        }
    }
}
