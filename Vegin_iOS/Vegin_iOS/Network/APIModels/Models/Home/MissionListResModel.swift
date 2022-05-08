//
//  MissionListResModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/08.
//

import Foundation

// MARK: - MissionListResModel
struct MissionListResModel: Codable {
    let missionID: Int
    let characterID: Int
    let progress: [Int]
    let inProgress: Bool
    let randomText: Int

    enum CodingKeys: String, CodingKey {
        case missionID = "missionId"
        case characterID = "characterId"
        case progress, inProgress, randomText
    }
}
