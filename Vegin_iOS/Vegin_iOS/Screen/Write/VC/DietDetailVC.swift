//
//  DietDetailVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/14.
//

import UIKit

class DietDetailVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
    
    /// 게시글 길이에 따른 동적 높이 셀 구현
    @IBOutlet weak var dietPostTV: UITableView! {
        didSet {
            dietPostTV.rowHeight = UITableView.automaticDimension
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToNaviBar()
        registerTVC()
        setUpTV()
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
            return dietDetailImgTVC
        } else if indexPath.section == 1 {
            return dietDetailIconTVC
        } else if indexPath.section == 2 {
            return dietDetailInfoTVC
        } else if indexPath.section == 3 {
            return dietDetailMemoTVC
        } else {
            return UITableViewCell()
        }
    }
}
