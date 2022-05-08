//
//  EmojiCountCVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/07.
//

import UIKit

class EmojiCountCVC: BaseCVC {

    // MARK: IBOutlet
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var emojiImgView: UIImageView!
    @IBOutlet weak var emojiCountLabel: UILabel!
    
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
        bgView.makeRounded(cornerRadius: 0.5 * bgView.bounds.size.height)
    }
}

extension EmojiCountCVC {
    // TODO: 서버 연결 후 모델에서 데이터 받아서 넣어주기
    func setData() {
        
    }
}
