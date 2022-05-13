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
    @IBOutlet weak var profileImgView: UIImageView!
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
        
        switch postData.writer.profileImageID {
        case 1:
            profileImgView.image = UIImage(named: "tomato_profile")
        case 2:
            profileImgView.image = UIImage(named: "carrot_profile")
        case 3:
            profileImgView.image = UIImage(named: "onion_profile")
        case 4:
            profileImgView.image = UIImage(named: "springOnion_profile")
        case 5:
            profileImgView.image = UIImage(named: "cabbage_profile")
        case 6:
            profileImgView.image = UIImage(named: "waterMelon_profile")
        case 7:
            profileImgView.image = UIImage(named: "corn_profile")
        case 8:
            profileImgView.image = UIImage(named: "blueberry_profile")
        case 9:
            profileImgView.image = UIImage(named: "strawberry_profile")
        case 10:
            profileImgView.image = UIImage(named: "pumpkin_profile")
        default:
            profileImgView.image = UIImage(named: "tomato_profile")
        }
    
        nickNameLabel.text = postData.writer.nickname
        dateLabel.text = postData.createdAt.serverTimeToString(forUse: .forDefault)
        contentImgView.kf.setImage(with: url)
        categoryLabel.text = postData.tag
        titleLabel.text = postData.title
    }
}
