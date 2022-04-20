//
//  WriteResModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/17.
//

import Foundation

// MARK: - WriteResModel
struct WriteResModel: Codable {
    let postID: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case createdAt
    }
}
