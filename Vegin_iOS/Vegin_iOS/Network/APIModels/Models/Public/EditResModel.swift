//
//  EditResModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/02.
//

import Foundation

// MARK: - EditResModel
struct EditResModel: Codable {
    let postID: Int
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case updatedAt
    }
}
