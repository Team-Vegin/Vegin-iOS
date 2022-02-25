//
//  AppContentDataModel.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/25.
//

import Foundation
import UIKit

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

