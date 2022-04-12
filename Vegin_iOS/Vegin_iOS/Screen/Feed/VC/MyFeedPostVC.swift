//
//  MyFeedPostVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/15.
//

import UIKit

class MyFeedPostVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var feedPostTV: UITableView!
    
    // MARK: Properties
    var feedMyPostList: [FeedListDataModel] = []
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToNaviBar()
        registerTVC()
        setUpTV()
        getMyPostList()
    }
    
    // MARK: IBAction
    @IBAction func tapNaviBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UI
extension MyFeedPostVC {
    
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
extension MyFeedPostVC {
    private func registerTVC() {
        FeedMyPostEmptyTVC.register(target: feedPostTV)
        FeedMainPostTVC.register(target: feedPostTV)
    }
    
    private func setUpTV() {
        feedPostTV.delegate = self
        feedPostTV.dataSource = self
    }
}

extension MyFeedPostVC: UITableViewDelegate {
    
    /// section 2개로 나눔
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 15
        } else if indexPath.section == 1 {
            return 102
        } else {
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension MyFeedPostVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return feedMyPostList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: FeedMyPostEmptyTVC.className) as? FeedMyPostEmptyTVC,
              let cell = tableView.dequeueReusableCell(withIdentifier: FeedMainPostTVC.className) as? FeedMainPostTVC else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            return emptyCell
        } else if indexPath.section == 1 {
            cell.setData(postData: feedMyPostList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let feedDetailVC = UIStoryboard.init(name: Identifiers.FeedDetailSB, bundle: nil).instantiateViewController(withIdentifier: FeedDetailVC.className) as? FeedDetailVC else { return }
            
            feedDetailVC.postId = feedMyPostList[indexPath.row].postID
            self.navigationController?.pushViewController(feedDetailVC, animated: true)
        }
    }
}

// MARK: - Network
extension MyFeedPostVC {
    
    /// 내가 쓴 게시글 조회 메서드
    private func getMyPostList() {
        self.activityIndicator.startAnimating()
        FeedAPI.shared.getMyFeedListAPI() { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? [FeedListDataModel] {
                    DispatchQueue.main.async {
                        self.feedMyPostList = data
                        self.feedPostTV.reloadData()
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
