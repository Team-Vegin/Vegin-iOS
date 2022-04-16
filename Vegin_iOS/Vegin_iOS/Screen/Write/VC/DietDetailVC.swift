//
//  DietDetailVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/14.
//

import UIKit

class DietDetailVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var naviTitleLabel: UILabel!
    
    // MARK: Properties
    var selectedDate: String = ""
    var postId: Int?
    var detailDiet: DietPostDataModel = DietPostDataModel(postID: 0, meal: [0], mealTime: 0, amount: 0, memo: "", imageURL: "", createdAt: "")
    
    /// 게시글 길이에 따른 동적 높이 셀 구현
    @IBOutlet weak var dietPostTV: UITableView! {
        didSet {
            dietPostTV.rowHeight = UITableView.automaticDimension
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addShadowToNaviBar()
        registerTVC()
        setUpTV()
        getDietDetail(postID: self.postId ?? 0)
    }
    
    @IBAction func tapBackNaviBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapRightNaviBtn(_ sender: UIButton) {
        makeTwoAlertWithCancel(okTitle: "수정하기", secondOkTitle: "삭제하기", okAction: { _ in
            print("수정하기")
        }, secondOkAction: { _ in
            print("삭제하기")
        })
    }
}

// MARK: - UI
extension DietDetailVC {
    private func configureUI() {
        naviTitleLabel.text = selectedDate + " 식단"
    }
    
    /// NaviBar dropShadow 설정 함수
    private func addShadowToNaviBar() {
        naviView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        naviView.layer.shadowOffset = CGSize(width: 0, height: 4)
        naviView.layer.shadowRadius = 8
        naviView.layer.shadowOpacity = 1
        naviView.layer.masksToBounds = false
    }
}

// MARK: - Custom Methods
extension DietDetailVC {
    private func registerTVC() {
        DietDetailImgTVC.register(target: dietPostTV)
        DietDetailIconTVC.register(target: dietPostTV)
        DietDetailInfoTVC.register(target: dietPostTV)
        DietDetailMemoTVC.register(target: dietPostTV)
    }
    
    private func setUpTV() {
        dietPostTV.dataSource = self
        dietPostTV.delegate = self
    }
}

// MARK: - UITableViewDelegate
extension DietDetailVC: UITableViewDelegate {
    
    /// section 4개로 나눔
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 341
        } else if indexPath.section == 1 {
            return 77
        } else if indexPath.section == 2 {
            return 87
        } else if indexPath.section == 3 {
            return UITableView.automaticDimension
        } else {
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension DietDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dietDetailImgTVC = tableView.dequeueReusableCell(withIdentifier: DietDetailImgTVC.className) as? DietDetailImgTVC,
              let dietDetailIconTVC = tableView.dequeueReusableCell(withIdentifier: DietDetailIconTVC.className) as? DietDetailIconTVC,
              let dietDetailInfoTVC = tableView.dequeueReusableCell(withIdentifier: DietDetailInfoTVC.className) as? DietDetailInfoTVC,
              let dietDetailMemoTVC = tableView.dequeueReusableCell(withIdentifier: DietDetailMemoTVC.className) as? DietDetailMemoTVC else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            dietDetailImgTVC.setData(dietData: detailDiet)
            return dietDetailImgTVC
        } else if indexPath.section == 1 {
            dietDetailIconTVC.iconImgList = detailDiet.meal
            return dietDetailIconTVC
        } else if indexPath.section == 2 {
            dietDetailInfoTVC.setData(dietData: detailDiet)
            return dietDetailInfoTVC
        } else if indexPath.section == 3 {
            dietDetailMemoTVC.setData(dietData: detailDiet)
            return dietDetailMemoTVC
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - Network
extension DietDetailVC {
    
    /// 식단 상세 조회 메서드
    private func getDietDetail(postID: Int) {
        self.activityIndicator.startAnimating()
        DietAPI.shared.getDietDetailAPI(postID: postID) { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? DietPostDataModel {
                    DispatchQueue.main.async {
                        print(data)
                        self.detailDiet = data
                        self.dietPostTV.reloadData()
                    }
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
