//
//  CharacterBookCVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/03/28.
//

import UIKit

class CharacterBookCVC: BaseCVC {
    @IBOutlet weak var characterImgView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var firstMissionLabel: UILabel!
    @IBOutlet weak var secondMissionLabel: UILabel!
    @IBOutlet weak var thirdMissionLabel: UILabel!
    @IBOutlet weak var chooseBtn: VeginBtn! {
        didSet {
            chooseBtn.isActivated = false
            chooseBtn.setTitleWithStyle(title: "캐릭터 선택하기", size: 16, weight: .bold)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: - Custom Methods
extension CharacterBookCVC {
    func setData(characterData: CharacterBookData) {
        characterImgView.image = characterData.makeCharacterImg()
        characterNameLabel.text = characterData.characterName
        firstMissionLabel.text = characterData.firstMission
        secondMissionLabel.text = characterData.secondMission
        thirdMissionLabel.text = characterData.thirdMission
    }
}
