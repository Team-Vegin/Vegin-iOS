//
//  FeedAPI.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/11.
//

import Foundation
import Moya

class FeedAPI {
    static let shared = FeedAPI()
    var provider = MoyaProvider<FeedService>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
}

// MARK: - API
extension FeedAPI {
    
    /// [GET] 게시글 리스트 조회
    func getFeedListAPI(tagID: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        provider.request(.getFeedList(tagID: tagID)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                completion(self.getFeedListJudgeData(status: statusCode, data: data))
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

// MARK: - judgeData
extension FeedAPI {
    private func getFeedListJudgeData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<[FeedListDataModel]>.self, from: data) else { return .pathErr }
        
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
