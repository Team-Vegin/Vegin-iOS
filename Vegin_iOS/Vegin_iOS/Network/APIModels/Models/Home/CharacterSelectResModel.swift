//
//  CharacterSelectResModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/09.
//

import Foundation

// MARK: - CharacterSelectResModel
struct CharacterSelectResModel: Codable {
    let userID: Int
    let character: Int

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case character
    }
}
