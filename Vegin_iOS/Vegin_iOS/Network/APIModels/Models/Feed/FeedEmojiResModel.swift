//
//  FeedEmojiResModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/17.
//

import Foundation

// MARK: - FeedEmojiResModel
struct FeedEmojiResModel: Codable {
    let postID: Int
    let emojiID: Int
    let isDeleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case emojiID = "emojiId"
        case isDeleted
    }
}
