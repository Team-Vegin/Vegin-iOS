//
//  NetworkResult.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/30.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
