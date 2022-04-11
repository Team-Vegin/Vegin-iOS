//
//  FeedMainPostTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/25.
//

import UIKit
import Kingfisher

class FeedMainPostTVC: BaseTVC {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnailImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - UI
extension FeedMainPostTVC {
    private func configureUI() {
        thumbnailImgView.makeRounded(cornerRadius: 10.adjusted)
        contentView.backgroundColor = .white
    }
}

// MARK: - Custom Methods
extension FeedMainPostTVC {
    func setData(postData: FeedListDataModel) {
        let url = URL(string: postData.imageURL)
        
        titleLabel.text = postData.title
        contentLabel.text = postData.content
        nickNameLabel.text = postData.tag
        dateLabel.text = postData.createdAt.serverTimeToString(forUse: .forDefault)
        thumbnailImgView.kf.setImage(with: url)
    }
    
}
