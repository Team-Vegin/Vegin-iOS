//
//  FeedDetailTitleTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/12.
//

import UIKit
import Kingfisher

class FeedDetailTitleTVC: BaseTVC {

    // MARK: IBOutlet
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentImgView: UIImageView!
    @IBOutlet weak var categoryVIew: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureUI() {
        contentImgView.makeRounded(cornerRadius: 20.adjusted)
        categoryVIew.makeRounded(cornerRadius: 0.5 * categoryVIew.bounds.size.height)
    }
    
    func setData(postData: FeedPostDataModel) {
        let url = URL(string: postData.imageURL)
        
        nickNameLabel.text = postData.writer.nickname
        dateLabel.text = postData.createdAt.serverTimeToString(forUse: .forDefault)
        contentImgView.kf.setImage(with: url)
        categoryLabel.text = postData.tag
        titleLabel.text = postData.title
    }
}
