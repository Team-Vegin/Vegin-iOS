//
//  UIColor+.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/11.
//

import UIKit

extension UIColor {
    
    @nonobjc class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var background: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 244.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var main: UIColor {
        return UIColor(red: 194.0 / 255.0, green: 223.0 / 255.0, blue: 165.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var darkMain: UIColor {
        return UIColor(red: 82.0 / 255.0, green: 153.0 / 255.0, blue: 90.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var darkText: UIColor {
        return UIColor(red: 27.0 / 255.0, green: 45.0 / 255.0, blue: 25.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var darkGray: UIColor {
        return UIColor(red: 105.0 / 255.0, green: 105.0 / 255.0, blue: 105.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gray0: UIColor {
        return UIColor(red: 156.0 / 255.0, green: 156.0 / 255.0, blue: 156.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var defaultGray: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var defaultTextGray: UIColor {
        return UIColor(red: 168.0 / 255.0, green: 168.0 / 255.0, blue: 168.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var errorTextRed: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 9.0 / 255.0, blue: 9.0 / 255.0, alpha: 1.0)
    }
}
