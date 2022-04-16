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
}

extension DietService: BaseTargetType {
    
    var path: String {
        switch self {
        case .getDietList(let date):
            return "/diet/day/\(date)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDietList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getDietList:
            return .requestPlain
        }
    }
}
