//
//  DietDetailImgTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/14.
//

import UIKit
import Kingfisher

class DietDetailImgTVC: BaseTVC {

    // MARK: IBOutlet
    @IBOutlet weak var foodImgView: UIImageView!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - UI
extension DietDetailImgTVC {
    private func configureUI() {
        foodImgView.makeRounded(cornerRadius: 20.adjusted)
    }
}

// MARK: - Custom Methods
extension DietDetailImgTVC {
    func setData(dietData: DietPostDataModel) {
        let url = URL(string: dietData.imageURL)
        foodImgView.kf.setImage(with: url)
    }
}
