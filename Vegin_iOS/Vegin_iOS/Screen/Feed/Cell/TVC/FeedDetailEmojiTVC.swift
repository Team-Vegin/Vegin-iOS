//
//  FeedDetailEmojiTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/13.
//

import UIKit

class FeedDetailEmojiTVC: BaseTVC {

    var tapPlusBtnAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapPlusBtn(_ sender: UIButton) {
        tapPlusBtnAction?()
    }
    
}
