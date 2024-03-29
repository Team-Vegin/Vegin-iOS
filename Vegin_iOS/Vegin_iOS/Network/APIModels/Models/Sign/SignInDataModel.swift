//
//  SignInDataModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/01.
//

import Foundation

// MARK: - SignInDataModel
struct SignInDataModel: Codable {
    let user: User
    let accesstoken: String
}

// MARK: - User
struct User: Codable {
    let userID: Int
    let email: String
    let nickname: String
    let character: Int
    let orientation: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case email, character, nickname, orientation
    }
}
