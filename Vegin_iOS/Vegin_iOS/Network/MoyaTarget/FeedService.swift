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
}

extension FeedService: BaseTargetType {
    var path: String {
        switch self {
        case .getFeedList(let tagID):
            return "/post/list/\(tagID)"
        case .getMyFeedList:
            return "/post/myList"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getFeedList, .getMyFeedList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        /// 피드 게시글 리스트 조회
        case .getFeedList, .getMyFeedList:
            return .requestPlain
        }
    }
}
