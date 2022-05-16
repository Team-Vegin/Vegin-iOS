//
//  MyPageAPI.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/15.
//

import Foundation
import Moya

class MyPageAPI {
    static let shared = MyPageAPI()
    var provider = MoyaProvider<MyPageService>(plugins: [NetworkLoggerPlugin()])
}

// MARK: - API
extension MyPageAPI {
    
    /// [GET] 마이페이지 정보 조회
    func getMypageInfoAPI(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        provider.request(.getMypageInfo) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                completion(self.getMypageInfoJudgeData(status: statusCode, data: data))
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

// MARK: - judgeData
extension MyPageAPI {
    private func getMypageInfoJudgeData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<MyPageDataModel>.self, from: data) else { return .pathErr }
        
        switch status {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 400:
            return .requestErr(decodedData.message)
        case 404:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
