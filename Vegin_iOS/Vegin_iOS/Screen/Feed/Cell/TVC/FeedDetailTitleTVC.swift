//
//  FeedDetailTitleTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/12.
//

import UIKit

class FeedDetailTitleTVC: BaseTVC {

    // MARK: IBOutlet
    @IBOutlet weak var contentImgView: UIImageView!
    @IBOutlet weak var categoryVIew: UIView!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: UI
    private func configureUI() {
        contentImgView.makeRounded(cornerRadius: 20.adjusted)
        categoryVIew.makeRounded(cornerRadius: 0.5 * categoryVIew.bounds.size.height)
    }
}
