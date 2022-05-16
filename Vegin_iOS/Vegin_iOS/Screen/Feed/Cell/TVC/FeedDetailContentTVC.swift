//
//  FeedDetailContentTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/13.
//

import UIKit

class FeedDetailContentTVC: BaseTVC {

    // MARK: IBOutlet
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(postData: FeedPostDataModel) {
        contentLabel.text = postData.content
    }
}
