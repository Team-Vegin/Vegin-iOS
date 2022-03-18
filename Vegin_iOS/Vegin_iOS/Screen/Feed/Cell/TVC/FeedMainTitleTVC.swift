//
//  FeedMainTitleTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/25.
//

import UIKit

class FeedMainTitleTVC: BaseTVC {

    // MARK: Properties
    var tapListBtnAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: IBAction
    @IBAction func tapListBtn(_ sender: UIButton) {
        tapListBtnAction?()
    }
}
