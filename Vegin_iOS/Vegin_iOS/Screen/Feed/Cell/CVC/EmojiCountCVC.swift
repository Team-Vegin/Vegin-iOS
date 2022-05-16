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

// MARK: - Custom Methods
extension EmojiCountCVC {
    func setData(data: EmojiList) {
        switch data.emojiID {
        case 1:
            emojiImgView.image = UIImage(named: "thumbUp")
        case 2:
            emojiImgView.image = UIImage(named: "smile")
        case 3:
            emojiImgView.image = UIImage(named: "laugh")
        case 4:
            emojiImgView.image = UIImage(named: "_fire")
        case 5:
            emojiImgView.image = UIImage(named: "heart")
        case 6:
            emojiImgView.image = UIImage(named: "party")
        default:
            emojiImgView.image = UIImage(named: "thumbUp")
        }
        
        emojiCountLabel.text = "\(data.count)"
        
        if !data.isDeleted {
            bgView.backgroundColor = UIColor(red: 0.761, green: 0.875, blue: 0.647, alpha: 1)
            bgView.layer.borderWidth = 1
            bgView.layer.borderColor = UIColor(red: 0.322, green: 0.6, blue: 0.353, alpha: 0.5).cgColor
            bgView.makeRounded(cornerRadius: 0.5 * bgView.bounds.size.height)
        } else {
            bgView.layer.borderColor = UIColor(red: 0.761, green: 0.875, blue: 0.647, alpha: 1).cgColor
            bgView.layer.borderWidth = 1
            bgView.makeRounded(cornerRadius: 0.5 * bgView.bounds.size.height)
        }
    }
}
