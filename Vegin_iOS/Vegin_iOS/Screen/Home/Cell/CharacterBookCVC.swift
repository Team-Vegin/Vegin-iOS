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
    @IBOutlet weak var characterExplainLabel: UILabel!
    @IBOutlet weak var firstImgView: UIImageView!
    @IBOutlet weak var secondImgView: UIImageView!
    @IBOutlet weak var thirdImgView: UIImageView!
    @IBOutlet weak var chooseBtn: VeginBtn!
    
    // Properties
    var cellTag: Int = -1
    var isClicked: Bool = false
    var delegate: SendDataDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDefaultBtnUI()
    }
    
    /// CVC 재사용 문제 해결을 위한 reload
    override func prepareForReuse() {
        chooseBtn.isHidden = false
    }
    
    @IBAction func tapStartBtn(_ sender: UIButton) {
        if let delegate = delegate {
            if isClicked {
                delegate.presentAlert(data: cellTag)
            } else {
                delegate.sendData(data: cellTag)
            }
        }
    }
}

// MARK: - Custom Methods
extension CharacterBookCVC {
    func setData(characterData: CharacterBookData, tagData: Int, missionData: MissionListResModel) {
        characterImgView.image = characterData.makeCharacterImg()
        characterNameLabel.text = characterData.characterName
        firstMissionLabel.text = characterData.firstMission
        secondMissionLabel.text = characterData.secondMission
        thirdMissionLabel.text = characterData.thirdMission
        characterExplainLabel.text = characterData.characterExplanation
        cellTag = tagData
        
        // 체크, 잠금 이미지 세팅
        if missionData.progress[0] == 0 {
            firstImgView.image = UIImage(named: "lock")
        } else {
            firstImgView.image = UIImage(named: "check_img")
        }
        
        if missionData.progress[1] == 0 {
            secondImgView.image = UIImage(named: "lock")
        } else {
            secondImgView.image = UIImage(named: "check_img")
        }
        
        if missionData.progress[2] == 0 {
            thirdImgView.image = UIImage(named: "lock")
        } else {
            thirdImgView.image = UIImage(named: "check_img")
        }
           
    }
    
    /// 미션 중이지 않은 버튼 UI 설정 메서드
    func setDefaultBtnUI() {
        chooseBtn.isActivated = true
        chooseBtn.setImage(UIImage(named: "cheerUp_light"), for: .normal)
        chooseBtn.backgroundColor = .darkMain
        chooseBtn.setTitleWithStyle(title: " 도전하기", size: 16, weight: .bold)
    }
    
    /// 미션 중인 버튼 UI 설정 메서드
    func setSelectedBtnUI() {
        chooseBtn.isActivated = true
        chooseBtn.setImage(UIImage(named: "delete_light"), for: .normal)
        chooseBtn.backgroundColor = .gray0
        chooseBtn.setTitleWithStyle(title: " 미션 중단하기", size: 16, weight: .bold)
    }
}
