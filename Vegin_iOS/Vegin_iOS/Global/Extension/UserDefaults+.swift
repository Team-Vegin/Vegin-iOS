//
//  UserDefaults+.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/12.
//

import Foundation

extension UserDefaults {
    
    /// UserDefaults key value가 많아지면 관리하기 어려워지므로 enum 'Keys'로 묶어 관리합니다.
    enum Keys {
        
        /// String
        static var AccessToken = "AccessToken"
        
        /// Int
        static var UserID = "userID"
    }
}
