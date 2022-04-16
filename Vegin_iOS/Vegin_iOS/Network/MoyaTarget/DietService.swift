//
//  DietService.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/30.
//

import Foundation
import Moya

enum DietService {
    case getDietList(date: String)
    case getDietDetail(postID: Int)
}

extension DietService: BaseTargetType {
    
    var path: String {
        switch self {
        case .getDietList(let date):
            return "/diet/day/\(date)"
        case .getDietDetail(let postID):
            return "/diet/\(postID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDietList, .getDietDetail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getDietList, .getDietDetail:
            return .requestPlain
        }
    }
}
