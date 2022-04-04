//
//  SignUpDataModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/04.
//

import Foundation

// MARK: - DataClass
struct SignUpDataModel: Codable {
    let user: newUser
}

// MARK: - newUser
struct newUser: Codable {
    let userID: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case createdAt
    }
}
