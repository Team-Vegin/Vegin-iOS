//
//  AppContentDataModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/25.
//

import Foundation
import UIKit

/// 피드 탭 포스트 리스트 위한 모델
struct FeedPostData {
    let title: String
    let content: String
    let nickName: String
    let date: String
    let thumbnailImgName: String
    
    func makeThumbnailImg() -> UIImage? {
        return UIImage(named: thumbnailImgName)
    }
}

/// 식단 목록 뷰 리스트 위한 모델
struct DietPostData {
    let title: String
    let content: String
    let thumbnailImgName: String
    let iconImgName: String
    
    func makeThumbnailImg() -> UIImage? {
        return UIImage(named: thumbnailImgName)
    }
    
    func makeIconImg() -> UIImage? {
        return UIImage(named: iconImgName)
    }
}

/// 피드 메인 뷰 카테고리 리스트 위한 모델
struct CategoryData {
    let title: String
}

