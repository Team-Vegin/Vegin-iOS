//
//  MyPageDataModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/15.
//

import Foundation

// MARK: - DataClass
struct MyPageDataModel: Codable {
    let orientation: String
    let nickname: String
    let dayCount: Int
    let dietCountList: [DietCountList]
}

// MARK: - DietCountList
struct DietCountList: Codable {
    let meal, count: Int
}
