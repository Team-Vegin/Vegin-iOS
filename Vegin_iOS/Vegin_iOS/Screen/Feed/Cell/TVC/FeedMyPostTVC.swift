//
//  FeedMyPostTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/15.
//

import UIKit

class FeedMyPostTVC: BaseTVC {

    @IBOutlet weak var thumbnailImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - UI
extension FeedMyPostTVC {
    private func configureUI() {
        thumbnailImgView.makeRounded(cornerRadius: 10.adjusted)
    }
}

// MARK: - Custom Methods
extension FeedMyPostTVC {
    func setData(postData: FeedMyPostListData) {
        thumbnailImgView.image = postData.makeThumbnailImg()
        titleLabel.text = postData.title
        contentLabel.text = postData.content
        nickNameLabel.text = postData.nickName
        dateLabel.text = postData.date
        categoryLabel.text = postData.category
    }
}
