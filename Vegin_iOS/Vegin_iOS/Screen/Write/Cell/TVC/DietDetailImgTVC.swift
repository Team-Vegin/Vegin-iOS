//
//  DietDetailImgTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/14.
//

import UIKit

class DietDetailImgTVC: BaseTVC {

    // MARK: IBOutlet
    @IBOutlet weak var foodImgView: UIImageView!
    
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
