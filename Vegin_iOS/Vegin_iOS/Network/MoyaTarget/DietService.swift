//
//  DietService.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/30.
//

import Foundation
import Moya
import CoreMedia

enum DietService {
    case getDietList(date: String)
    case getDietDetail(postID: Int)
    case createDietPost(image: UIImage, meal: [Int], mealTime: Int, amount: Int, memo: String, date: String)
}

extension DietService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getDietList(let date):
            return "/diet/day/\(date)"
        case .getDietDetail(let postID):
            return "/diet/\(postID)"
        case .createDietPost:
            return "/diet"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDietList, .getDietDetail:
            return .get
        case .createDietPost:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getDietList, .getDietDetail:
            return .requestPlain
        case .createDietPost(let image, let meal, let mealTime, let amount, let memo, let date):
            var multiPartData: [Moya.MultipartFormData] = []
            
            let body: [String : Any] = [
                "meal" : meal,
                "mealTime" : mealTime,
                "amount" : amount,
                "memo" : memo,
                "date" : date
            ]
            
            let imageData = MultipartFormData(provider: .data(image.jpegData(compressionQuality: 1.0) ?? Data()), name: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            multiPartData.append(imageData)
            
            
            for (key, value) in body {
                if key == "meal" {
                    let jsonData = arrayToJson(arr: value)
                    let formData = MultipartFormData(provider: .data("\(jsonData)".data(using: .utf8)!), name: key, mimeType: "text/plain")
                    multiPartData.append(formData)
                } else {
                    let formData = MultipartFormData(provider: .data("\(value)".data(using: .utf8) ?? Data()), name: "\(key)", mimeType: "text/plain")
                    multiPartData.append(formData)
                }
            }
            return .uploadMultipart(multiPartData)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaults.Keys.AccessToken) ?? ""
        
        switch self {
        case .getDietList, .getDietDetail:
            return ["Content-Type": "application/json", "accessToken": accessToken]
        case .createDietPost:
            return ["Content-Type": "multipart/form-data", "accessToken": accessToken]
        }
    }
}

extension DietService {
    
    /// 배열값 인코딩 메서드
    private func arrayToJson(arr: Any) -> String {
        let arrData = String(describing: arr)
        var jsonData = arrData.replacingOccurrences(of: "[", with: "{")
        jsonData = jsonData.replacingOccurrences(of: "]", with: "}")
        
        return jsonData
    }
}
