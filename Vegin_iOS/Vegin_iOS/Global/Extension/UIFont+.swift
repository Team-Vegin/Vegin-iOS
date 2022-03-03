//
//  UIFont+.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/03.
//

import UIKit

enum FontWeight {
    case light, regular, medium, bold, semiBold
}

extension UIFont {
    
    // MARK: Pretendard Font
    class func PretendardL(size: CGFloat) -> UIFont! {
        return UIFont(name: "Pretendard-Light", size: size)
    }
    
    class func PretendardR(size: CGFloat) -> UIFont! {
        return UIFont(name: "Pretendard-Regular", size: size)
    }
    
    class func PretendardM(size: CGFloat) -> UIFont! {
        return UIFont(name: "Pretendard-Medium", size: size)
    }
    
    class func PretendardB(size: CGFloat) -> UIFont! {
        return UIFont(name: "Pretendard-Bold", size: size)
    }
    
    class func PretendardSB(size: CGFloat) -> UIFont! {
        return UIFont(name: "Pretendard-SemiBold", size: size)
    }
}
