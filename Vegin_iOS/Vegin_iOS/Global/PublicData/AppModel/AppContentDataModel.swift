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
/// 홈 탭 도감 뷰 리스트 위한 모델
struct CharacterBookData {
    let characterImgName: String
    let characterName: String
    let firstMission: String
    let secondMission: String
    let thirdMission: String
    
    func makeCharacterImg() -> UIImage? {
        return UIImage(named: characterImgName)
    }
}

/// 피드 메인 뷰 카테고리 리스트 위한 모델
struct CategoryData {
    let title: String
}

/// 식단 상세 뷰 아이콘 리스트 위한 모델
struct IconImgData {
    let iconImgName: String
    
    func makeIconImg() -> UIImage? {
        return UIImage(named: iconImgName)
    }
}

/// 내가 쓴 피드 게시글 리스트 위한 모델
struct FeedMyPostListData {
    let title: String
    let content: String
    let nickName: String
    let date: String
    let category: String
    let thumbnailImgName: String
    
    func makeThumbnailImg() -> UIImage? {
        return UIImage(named: thumbnailImgName)
    }
}

/// 온보딩 페이지 뷰 리스트 위한 모델
struct OnboardingData {
    let onboardingImgName: String
    let boldText: String
    let contentText: String
    
    func makeOnboardingImg() -> UIImage? {
        return UIImage(named: onboardingImgName)
    }
}
