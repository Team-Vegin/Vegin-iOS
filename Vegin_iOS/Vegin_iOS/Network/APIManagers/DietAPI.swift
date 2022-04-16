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
    var provider = MoyaProvider<DietService>(plugins: [NetworkLoggerPlugin()])
}

// MARK: - API
extension DietAPI {
    /// [GET] 하루 식단 리스트 조회
    func getDietListAPI(date: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        provider.request(.getDietList(date: date)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                completion(self.getDietListJudgeData(status: statusCode, data: data))
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 식단 상세 조회
    func getDietDetailAPI(postID: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        provider.request(.getDietDetail(postID: postID)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                completion(self.getDietDetailJudgeData(status: statusCode, data: data))
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

// MARK: - judgeData
extension DietAPI {
    private func getDietListJudgeData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<[DietListDataModel]>.self, from: data) else { return .pathErr }
        
        switch status {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 400:
            return .requestErr(decodedData.message)
        case 404:
            return .requestErr(404)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func getDietDetailJudgeData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<DietPostDataModel>.self, from: data) else { return .pathErr }
        
        switch status {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 400:
            return .requestErr(decodedData.message)
        case 404:
            return .requestErr(404)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
