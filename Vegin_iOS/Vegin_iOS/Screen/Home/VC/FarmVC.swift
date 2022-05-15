//
//  FarmVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/24.
//

import UIKit


class FarmVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var characterBookBtn: UIButton!
    @IBOutlet weak var missionInfoView: UIView!
    @IBOutlet weak var progressBarImgView: UIImageView!
    @IBOutlet weak var missionStatusLabel: UILabel!
    @IBOutlet weak var noMissionLabel: UILabel!
    @IBOutlet weak var characterImgView: UIImageView!
    @IBOutlet weak var itemImgView: UIImageView!
    
    // MARK: Properties
    var detailMissionData: [MissionListResModel] = []
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getMissionListStatus()
        setCharacterImg()
        setUpMessage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabbar()
        getMissionListStatus()
        setCharacterImg()
        setUpMessage()
    }
    
    // MARK: IBAction
    @IBAction func tapCahracterPageBtn(_ sender: UIButton) {
        guard let CharacterBookVC = UIStoryboard.init(name: "HomeSB", bundle: nil).instantiateViewController(withIdentifier: CharacterBookVC.className) as? CharacterBookVC else { return }
        
        self.navigationController?.pushViewController(CharacterBookVC, animated: true)
    }
    
    @IBAction func tapInstagramShareBtn(_ sender: UIButton) {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let renderImage = renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        if let storyShareURL = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(storyShareURL) {
                guard let imageData = renderImage.pngData() else {return}

                let pasteboardItems: [String: Any] = [
                    "com.instagram.sharedSticker.stickerImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor": "#8D8D88",
                    "com.instagram.sharedSticker.backgroundBottomColor": "#8D8D88"]

                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)]

                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                UIApplication.shared.open(storyShareURL, options: [:], completionHandler: nil)
            } else {
                print("인스타 앱이 깔려있지 않습니다.")
            }
        }
    }
}

// MARK: - UI
extension FarmVC {
    private func configureUI() {
        messageLabel.setLineSpacing(lineSpacing: 2)
        missionInfoView.makeRounded(cornerRadius: 0.5 * missionInfoView.bounds.height)
        noMissionLabel.isHidden = true
    }
    
    private func setCharacterImg() {
        switch UserDefaults.standard.integer(forKey: UserDefaults.Keys.CharacterID) {
        case 1:
            characterImgView.image = UIImage(named: "tomato")
            itemImgView.image = UIImage(named: "tomato_bg")
        case 2:
            characterImgView.image = UIImage(named: "carrot")
            itemImgView.image = UIImage(named: "carrot_bg")
        case 3:
            characterImgView.image = UIImage(named: "onion")
            itemImgView.image = UIImage(named: "onion_bg")
        case 4:
            characterImgView.image = UIImage(named: "springOnion")
            itemImgView.image = UIImage(named: "springOnion_bg")
        case 5:
            characterImgView.image = UIImage(named: "cabbage")
            itemImgView.image = UIImage(named: "cabbage_bg")
        case 6:
            characterImgView.image = UIImage(named: "waterMelon")
            itemImgView.image = UIImage(named: "watermelon_bg")
        case 7:
            characterImgView.image = UIImage(named: "corn")
            itemImgView.image = UIImage(named: "corn_bg")
        case 8:
            characterImgView.image = UIImage(named: "blueberry")
            itemImgView.image = UIImage(named: "blueberry_bg")
        case 9:
            characterImgView.image = UIImage(named: "strawberry")
            itemImgView.image = UIImage(named: "strawberry_bg")
        case 10:
            characterImgView.image = UIImage(named: "pumpkin")
            itemImgView.image = UIImage(named: "pumpkin_bg")
        default:
            characterImgView.image = UIImage(named: "tomato")
            itemImgView.image = UIImage(named: "tomato_bg")
        }
    }
}

// MARK: - Custom Methods
extension FarmVC {
    private func setUpProgress() {
        for i in 0...detailMissionData.count - 1 {
            if detailMissionData[i].inProgress == false {
                self.progressBarImgView.image = UIImage(named: "progressBar_empty")
                self.missionStatusLabel.isHidden = true
                self.missionInfoView.isHidden = true
                self.noMissionLabel.isHidden = false
            } else {
                if detailMissionData[i].progress == [1, 1, 1] {
                    self.progressBarImgView.image = UIImage(named: "progressBar_last")
                    self.missionStatusLabel.text = "미션 완료 !"
                    self.missionStatusLabel.isHidden = false
                    self.missionInfoView.isHidden = false
                    self.noMissionLabel.isHidden = true
                    break
                } else if detailMissionData[i].progress == [0, 0, 0] {
                    self.progressBarImgView.image = UIImage(named: "progressBar")
                    self.missionStatusLabel.text = "미션 진행중.."
                    self.missionStatusLabel.isHidden = false
                    self.missionInfoView.isHidden = false
                    self.noMissionLabel.isHidden = true
                    break
                } else if detailMissionData[i].progress == [1, 0, 0] || detailMissionData[i].progress == [0, 1, 0] || detailMissionData[i].progress == [0, 0, 1] {
                    self.progressBarImgView.image = UIImage(named: "progressBar_first")
                    self.missionStatusLabel.text = "미션 진행중.."
                    self.missionStatusLabel.isHidden = false
                    self.missionInfoView.isHidden = false
                    self.noMissionLabel.isHidden = true
                    break
                } else {
                    self.progressBarImgView.image = UIImage(named: "progressBar_second")
                    self.missionStatusLabel.text = "미션 진행중.."
                    self.missionStatusLabel.isHidden = false
                    self.missionInfoView.isHidden = false
                    self.noMissionLabel.isHidden = true
                    break
                }
            }
        }
    }
    
    private func setUpMessage() {
        switch UserDefaults.standard.integer(forKey: UserDefaults.Keys.CharacterID) {
        case 1:
            messageLabel.text = CharacterLines.tomato.randomElement()
        case 2:
            messageLabel.text = CharacterLines.carrot.randomElement()
        case 3:
            messageLabel.text = CharacterLines.onion.randomElement()
        case 4:
            messageLabel.text = CharacterLines.springOnion.randomElement()
        case 5:
            messageLabel.text = CharacterLines.cabbage.randomElement()
        case 6:
            messageLabel.text = CharacterLines.waterMelon.randomElement()
        case 7:
            messageLabel.text = CharacterLines.corn.randomElement()
        case 8:
            messageLabel.text = CharacterLines.blueberry.randomElement()
        case 9:
            messageLabel.text = CharacterLines.strawberry.randomElement()
        case 10:
            messageLabel.text = CharacterLines.pumpkin.randomElement()
        default:
            messageLabel.text = CharacterLines.tomato.randomElement()
        }
    }
}

// MARK: - Network
extension FarmVC {
    
    /// 미션 리스트 현황 조회 메서드
    private func getMissionListStatus() {
        self.activityIndicator.startAnimating()
        HomeAPI.shared.getMissionListStatusAPI() { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? [MissionListResModel] {
                    print(data)
                    self.detailMissionData = data
                    self.setUpProgress()
                }
            case .requestErr(let res):
                self.activityIndicator.stopAnimating()
                print(res)
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.activityIndicator.stopAnimating()
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}

