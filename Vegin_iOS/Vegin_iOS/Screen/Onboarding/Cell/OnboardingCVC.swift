//
//  OnboardingCVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/04/26.
//

import UIKit

class OnboardingCVC: BaseCVC {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var boldTextLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        contentLabel.numberOfLines = 0
        contentLabel.sizeToFit()
        contentLabel.setLineSpacing(lineSpacing: 3)
        contentLabel.textAlignment = .center
    }
}

// MARK: - Custom Methods
extension OnboardingCVC {
    func setData(OnboardingData: OnboardingData) {
        imgView.image = OnboardingData.makeOnboardingImg()
        boldTextLabel.text = OnboardingData.boldText
        contentLabel.text = OnboardingData.contentText
    }
}
