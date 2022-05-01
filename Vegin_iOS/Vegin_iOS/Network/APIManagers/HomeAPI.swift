//
//  HomeAPI.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/02.
//

import Foundation
import Moya

class HomeAPI {
    static let shared = HomeAPI()
    var provider = MoyaProvider<HomeService>(plugins: [NetworkLoggerPlugin()])
}

// MARK: - API
extension HomeAPI {
    
    /// [POST] 미션 시작/중단하기
    func requestStartMissionAPI(missionID: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        provider.request(.requestStartMission(missionID: missionID)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                completion(self.startMissionJudgeData(status: statusCode, data: data))
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

// MARK: - judgeData
extension HomeAPI {
    private func startMissionJudgeData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<MissionStartResModel>.self, from: data) else { return .pathErr }
        
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
