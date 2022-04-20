//
//  PostResModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/16.
//

import Foundation

// MARK: - PostResModel
struct PostResModel: Codable {
    let postID: Int
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case isDeleted
    }
}
