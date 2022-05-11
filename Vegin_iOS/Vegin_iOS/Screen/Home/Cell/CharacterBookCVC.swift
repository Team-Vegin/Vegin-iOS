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
    @IBOutlet weak var warningLabel: UILabel!
    
    // Properties
    var cellTag: Int = -1
    var isClicked: Bool = false
    var isChosen: Bool = false // 캐릭터 선택
    var isFinished: Bool = false // 미션 달성
    var delegate: SendDataDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDefaultBtnUI()
    }
    
    /// CVC 재사용 문제 해결을 위한 초기화
    override func prepareForReuse() {
        chooseBtn.isHidden = false
        warningLabel.isHidden = true
    }
    
    @IBAction func tapStartBtn(_ sender: UIButton) {
        if let delegate = delegate {
            if isClicked {
                delegate.presentAlert(data: cellTag)
            } else if !isClicked && !isFinished {
                delegate.sendData(data: cellTag)
            } else if isFinished {
                delegate.changeCharacter(data: cellTag)
            }
        }
    }
}

// MARK: - Custom Methods
extension CharacterBookCVC {
    func setData(characterData: CharacterBookData, tagData: Int, missionData: MissionListResModel) {
        characterNameLabel.text = characterData.characterName
        firstMissionLabel.text = characterData.firstMission
        secondMissionLabel.text = characterData.secondMission
        thirdMissionLabel.text = characterData.thirdMission
        characterExplainLabel.text = characterData.characterExplanation
        cellTag = tagData
        
        if missionData.progress == [1, 1, 1] && !missionData.inProgress {
            characterImgView.image = characterData.makeMyCharacterImg()
        } else {
            characterImgView.image = characterData.makeHiddenCharacterImg()
        }
        
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
        warningLabel.isHidden = true
    }
    
    /// 미션 중인 버튼 UI 설정 메서드
    func setDoingMissionBtnUI() {
        chooseBtn.isActivated = true
        chooseBtn.setImage(UIImage(named: "delete_light"), for: .normal)
        chooseBtn.backgroundColor = .gray0
        chooseBtn.setTitleWithStyle(title: " 미션 중단하기", size: 16, weight: .bold)
        warningLabel.isHidden = false
    }
    
    /// 캐릭터 선택하기 버튼 UI 설정 메서드
    func setSelectCharacterBtnUI() {
        chooseBtn.isActivated = true
        chooseBtn.backgroundColor = .main
        chooseBtn.setTitleColor(.darkMain, for: .normal)
        chooseBtn.setImage(nil, for: .normal)
        chooseBtn.setTitleWithStyle(title: " 캐릭터 선택하기", size: 16, weight: .bold)
    }
    
    /// 선택된 캐릭터 버튼 UI 설정 메서드
    func setSelectedCharacterBtnUI() {
        chooseBtn.isActivated = false
        chooseBtn.setImage(nil, for: .normal)
        chooseBtn.setTitleWithStyle(title: "캐릭터 선택하기", size: 16, weight: .bold)
    }
}
