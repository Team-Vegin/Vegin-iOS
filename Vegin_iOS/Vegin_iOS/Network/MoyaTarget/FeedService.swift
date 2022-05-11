//
//  FeedService.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/11.
//

import Foundation
import Moya

enum FeedService {
    case getFeedList(tagID: Int)
    case getMyFeedList
    case getFeedDetailPost(postID: Int)
    case deleteFeedPost(postID: Int)
    case createFeedPost(image: UIImage, title: String, content: String, tagID: Int)
    case editFeedPost(postID: Int, image: UIImage, title: String, content: String, tagID: Int)
}

extension FeedService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getFeedList(let tagID):
            return "/post/list/\(tagID)"
        case .getMyFeedList:
            return "/post/myList"
        case .getFeedDetailPost(let postID), .deleteFeedPost(let postID), .editFeedPost(let postID, _, _, _, _):
            return "/post/\(postID)"
        case .createFeedPost:
            return "/post"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getFeedList, .getMyFeedList, .getFeedDetailPost:
            return .get
        case .deleteFeedPost:
            return .delete
        case .createFeedPost:
            return .post
        case .editFeedPost:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .getFeedList, .getMyFeedList, .getFeedDetailPost, .deleteFeedPost:
            return .requestPlain
        case .createFeedPost(let image, let title, let content, let tagID), .editFeedPost(_, let image, let title, let content, let tagID):
            var multiPartData: [Moya.MultipartFormData] = []
            
            let body: [String : Any] = [
                "image" : image,
                "title" : title,
                "content" : content,
                "tagId" : tagID
            ]
            
            let imageData = MultipartFormData(provider: .data(image.jpegData(compressionQuality: 1.0) ?? Data()), name: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            multiPartData.append(imageData)
            
            for (key, value) in body {
                let formData = MultipartFormData(provider: .data("\(value)".data(using: .utf8) ?? Data()), name: "\(key)", mimeType: "text/plain")
                multiPartData.append(formData)
            }
            return .uploadMultipart(multiPartData)
        }
    }
    
    var headers: [String : String]? {
        let accessToken = UserDefaults.standard.string(forKey: UserDefaults.Keys.AccessToken) ?? ""
        
        switch self {
        case .getFeedList, .getMyFeedList, .getFeedDetailPost, .deleteFeedPost:
            return ["Content-Type": "application/json", "accessToken": accessToken]
        case .createFeedPost, .editFeedPost:
            return ["Content-Type": "multipart/form-data", "accessToken": accessToken]
        }
    }
}
