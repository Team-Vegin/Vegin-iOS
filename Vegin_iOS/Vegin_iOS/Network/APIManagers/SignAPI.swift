//
//  SignAPI.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/01.
//

import Foundation
import Moya

class SignAPI {
    static let shared = SignAPI()
    var provider = MoyaProvider<SignService>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
}
    
// MARK: - API
extension SignAPI {
    /// [POST] 로그인 요청
    func requestSignInAPI(email: String, pw: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        provider.request(.requestSignIn(email: email, pw: pw)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                completion(self.signInJudgeData(status: statusCode, data: data))
                
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
}

// MARK: - judgeData
extension SignAPI {
    private func signInJudgeData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<SignInDataModel>.self, from: data) else { return .pathErr }
        
        switch status {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 400:
            return .requestErr(400)
        case 404:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
