//
//  FeedListDataModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/11.
//

import Foundation

// MARK: - FeedListDataModel
struct FeedListDataModel: Codable {
    let postID: Int
    let title, content, tag: String
    let imageURL: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case title, content, tag, imageURL, createdAt
    }
}
