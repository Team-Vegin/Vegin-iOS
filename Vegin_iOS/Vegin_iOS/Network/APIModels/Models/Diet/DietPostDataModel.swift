//
//  DietPostDataModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/17.
//

import Foundation

// MARK: - DietPostDataModel
struct DietPostDataModel: Codable {
    let postID: Int
    let meal: [Int]
    let mealTime, amount: Int
    let memo: String
    let imageURL: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case meal, mealTime, amount, memo, imageURL, createdAt
    }
}

