//
//  DietListTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/01.
//

import UIKit
import Kingfisher

class DietListTVC: BaseTVC {

    // MARK: IBOutlet
    @IBOutlet weak var thumbnailImgView: UIImageView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureUI() {
        thumbnailImgView.makeRounded(cornerRadius: 10.adjusted)
        contentLabel.setLineSpacing(lineSpacing: 5)
    }
}

// MARK: - Custom Methods
extension DietListTVC {
    func setData(postData: DietListDataModel) {
        let url = URL(string: postData.imageURL)
        let mealArray = postData.meal
        
        switch postData.mealTime {
        case 1:
            titleLabel.text = "아침"
        case 2:
            titleLabel.text = "아점"
        case 3:
            titleLabel.text = "점심"
        case 4:
            titleLabel.text = "점저"
        case 5:
            titleLabel.text = "저녁"
        default:
            break
        }
        contentLabel.text = postData.memo
        thumbnailImgView.kf.setImage(with: url)
        
        switch mealArray.last {
        case 1:
            iconImgView.image = UIImage(named: "level1")
        case 2:
            iconImgView.image = UIImage(named: "level2")
        case 3:
            iconImgView.image = UIImage(named: "level3")
        case 4:
            iconImgView.image = UIImage(named: "level4")
        case 5:
            iconImgView.image = UIImage(named: "level5")
        case 6:
            iconImgView.image = UIImage(named: "level6")
        case .none:
            iconImgView.image = UIImage(named: "level1")
        case .some(_):
            iconImgView.image = UIImage(named: "level1")
        }

    }
}
