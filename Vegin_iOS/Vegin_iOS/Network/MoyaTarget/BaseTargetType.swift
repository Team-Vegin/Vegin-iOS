//
//  BaseTargetType.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/30.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var sampleData: Data {
        return Data()
    }
}
