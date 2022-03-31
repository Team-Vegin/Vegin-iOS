//
//  DietAPI.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/30.
//

import Foundation
import Moya

class DietAPI {
    static let shared = DietAPI()
    var userProvider = MoyaProvider<DietService>(plugins: [NetworkLoggerPlugin()])
}
