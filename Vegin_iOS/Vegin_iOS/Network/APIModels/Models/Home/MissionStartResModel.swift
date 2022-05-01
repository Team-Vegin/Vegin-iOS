//
//  MissionStartResModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/02.
//

import Foundation

// MARK: - MissionStartResModel
struct MissionStartResModel: Codable {
    let userID: Int
    let missionID: Int
    let progress: [Int]
    let inProgress: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case missionID = "missionId"
        case progress, inProgress
    }
}
