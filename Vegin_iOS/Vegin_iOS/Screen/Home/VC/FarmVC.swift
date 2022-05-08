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
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getMissionListStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabbar()
    }
    
    // MARK: IBAction
    @IBAction func tapCahracterPageBtn(_ sender: UIButton) {
        guard let CharacterBookVC = UIStoryboard.init(name: "HomeSB", bundle: nil).instantiateViewController(withIdentifier: CharacterBookVC.className) as? CharacterBookVC else { return }
        
        self.navigationController?.pushViewController(CharacterBookVC, animated: true)
    }
}

// MARK: - UI
extension FarmVC {
    private func configureUI() {
        messageLabel.setLineSpacing(lineSpacing: 2)
        missionInfoView.makeRounded(cornerRadius: 0.5 * missionInfoView.bounds.height)
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
                    // TODO: 통신결과로 할 작업 함수 호출
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

