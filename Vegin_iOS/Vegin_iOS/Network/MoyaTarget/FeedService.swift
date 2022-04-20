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
}

extension FeedService: BaseTargetType {
    var path: String {
        switch self {
        case .getFeedList(let tagID):
            return "/post/list/\(tagID)"
        case .getMyFeedList:
            return "/post/myList"
        case .getFeedDetailPost(let postID), .deleteFeedPost(let postID):
            return "/post/\(postID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getFeedList, .getMyFeedList, .getFeedDetailPost:
            return .get
        case .deleteFeedPost:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getFeedList, .getMyFeedList, .getFeedDetailPost, .deleteFeedPost:
            return .requestPlain
        }
    }
}
