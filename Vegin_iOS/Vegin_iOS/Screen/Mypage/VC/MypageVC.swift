//
//  MypageVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/11.
//

import UIKit

class MypageVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var characterImgView: UIImageView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCharacterImg()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCharacterImg()
    }
}

extension MypageVC {
    
    /// 홈화면 적용 캐릭터에 따른 배경 캐릭터 이미지 적용 메서드
    private func setCharacterImg() {
        switch UserDefaults.standard.integer(forKey: UserDefaults.Keys.CharacterID) {
        case 1:
            characterImgView.image = UIImage(named: "mytomato")
        case 2:
            characterImgView.image = UIImage(named: "mycarrot")
        case 3:
            characterImgView.image = UIImage(named: "myonion")
        case 4:
            characterImgView.image = UIImage(named: "myspringOnion")
        case 5:
            characterImgView.image = UIImage(named: "mycabbage")
        case 6:
            characterImgView.image = UIImage(named: "mywaterMelon")
        case 7:
            characterImgView.image = UIImage(named: "mycorn")
        case 8:
            characterImgView.image = UIImage(named: "myblueberry")
        case 9:
            characterImgView.image = UIImage(named: "mystrawberry")
        case 10:
            characterImgView.image = UIImage(named: "mypumpkin")
        default:
            characterImgView.image = UIImage(named: "mytomato")
        }
    }
}
