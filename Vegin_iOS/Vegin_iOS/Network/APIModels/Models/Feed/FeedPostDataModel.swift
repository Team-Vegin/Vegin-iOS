//
//  FeedPostDataModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/13.
//

import Foundation

// MARK: - FeedPostDataModel
struct FeedPostDataModel: Codable {
    let postID: Int
    let title: String
    let content: String
    let tag: String
    let imageURL: String
    let createdAt: String
    let writer: Writer

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case title, content, tag, imageURL, createdAt, writer
    }
}

// MARK: - Writer
struct Writer: Codable {
    let userID: Int
    let nickname: String
    let profileImageID: Int

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case nickname
        case profileImageID = "profileImageId"
    }
}
