//
//  CharacterBookCVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/03/28.
//

import UIKit

class CharacterBookCVC: BaseCVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var characterImgView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var firstMissionLabel: UILabel!
    @IBOutlet weak var secondMissionLabel: UILabel!
    @IBOutlet weak var thirdMissionLabel: UILabel!
    @IBOutlet weak var chooseBtn: VeginBtn! {
        didSet {
            chooseBtn.isActivated = true
            chooseBtn.setTitleWithStyle(title: " 도전하기", size: 16, weight: .bold)
        }
    }
    
    // Properties
    var cellTag: Int = -1
    var isClicked: Bool = false
    var delegate: SendDataDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// CVC 재사용 문제 해결을 위한 reload
    override func prepareForReuse() {
        chooseBtn.isHidden = false
    }
    
    @IBAction func tapStartBtn(_ sender: UIButton) {
        if let delegate = delegate {
            if isClicked {
                delegate.presentAlert()
            } else {
                delegate.sendData(data: cellTag)
                isClicked = true
            }
        }
    }
}

// MARK: - Custom Methods
extension CharacterBookCVC {
    func setData(characterData: CharacterBookData, tagData: Int) {
        characterImgView.image = characterData.makeCharacterImg()
        characterNameLabel.text = characterData.characterName
        firstMissionLabel.text = characterData.firstMission
        secondMissionLabel.text = characterData.secondMission
        thirdMissionLabel.text = characterData.thirdMission
        cellTag = tagData
    }
    
    func setDefaultBtnUI() {
        chooseBtn.setImage(UIImage(named: "cheerUp_light"), for: .normal)
        chooseBtn.backgroundColor = .darkMain
        chooseBtn.setTitleWithStyle(title: " 도전하기", size: 16, weight: .bold)
    }
    
    func setSelectedBtnUI() {
        chooseBtn.setImage(UIImage(named: "delete_light"), for: .normal)
        chooseBtn.backgroundColor = .gray0
        chooseBtn.setTitleWithStyle(title: " 미션 중단하기", size: 16, weight: .bold)
    }
}
