//
//  EmojiCountCVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/07.
//

import UIKit

class EmojiCountCVC: UICollectionViewCell {

    // MARK: IBOutlet
    @IBOutlet weak var bgView: UIView!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

// MARK: - UI
extension EmojiCountCVC {
    private func configureUI() {
        bgView.layer.borderColor = UIColor(red: 0.761, green: 0.875, blue: 0.647, alpha: 1).cgColor
        bgView.layer.borderWidth = 1
    }
}
