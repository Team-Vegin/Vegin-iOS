//
//  DietListDataModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/16.
//

import Foundation

// MARK: - DietListDataModel
struct DietListDataModel: Codable {
    let postID: Int
    let date: String
    let meal: [Int]
    let mealTime, amount: Int
    let memo: String
    let imageURL: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case date, meal, mealTime, amount, memo, imageURL, createdAt
    }
}
