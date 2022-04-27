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
    @IBOutlet weak var contentText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Custom Methods
extension OnboardingCVC {
    func setData(OnboardingData: OnboardingData) {
        imgView.image = OnboardingData.makeOnboardingImg()
        boldTextLabel.text = OnboardingData.boldText
        contentText.text = OnboardingData.contentText
    }
}
