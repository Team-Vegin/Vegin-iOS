//
//  BaseCVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/11.
//

import UIKit

class BaseCVC: UICollectionViewCell {
    
}

// MARK: - CVRegisterable
extension BaseCVC: CVRegisterable {
    
    static var isFromNib: Bool {
        get {
            return true
        }
    }
}

