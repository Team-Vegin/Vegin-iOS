//
//  FeedDetailVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/12.
//

import UIKit

class FeedDetailVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
    
    /// 게시글 길이에 따른 동적 높이 셀 구현
    @IBOutlet weak var postTV: UITableView! {
        didSet {
            postTV.rowHeight = UITableView.automaticDimension
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToNaviBar()
        registerTVC()
        setUpTV()
    }
    
    // MARK: IBAction
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UI
extension FeedDetailVC {
    
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
extension FeedDetailVC {
    private func registerTVC() {
        FeedDetailTitleTVC.register(target: postTV)
        FeedDetailContentTVC.register(target: postTV)
        FeedDetailEmojiTVC.register(target: postTV)
    }
    
    private func setUpTV() {
        postTV.dataSource = self
        postTV.delegate = self
    }
}

// MARK: - UITableViewDelegate
extension FeedDetailVC: UITableViewDelegate {
    
    /// section 3개로 나눔
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 479
        } else if indexPath.section == 1 {
            return UITableView.automaticDimension
        } else if indexPath.section == 2 {
            return 78
        } else {
             return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension FeedDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let feedDetailTitleTVC = tableView.dequeueReusableCell(withIdentifier: FeedDetailTitleTVC.className) as? FeedDetailTitleTVC,
              let feedDetailContentTVC = tableView.dequeueReusableCell(withIdentifier: FeedDetailContentTVC.className) as? FeedDetailContentTVC,
              let feedDetailEmojiTVC = tableView.dequeueReusableCell(withIdentifier: FeedDetailEmojiTVC.className) as? FeedDetailEmojiTVC else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            return feedDetailTitleTVC
        } else if indexPath.section == 1 {
            return feedDetailContentTVC
        } else if indexPath.section == 2 {
            return feedDetailEmojiTVC
        } else {
            return UITableViewCell()
        }
    }
}

