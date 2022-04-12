//
//  FeedMainVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/25.
//

import UIKit

class FeedMainVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var feedTV: UITableView!
    
    var postList: [FeedListDataModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.feedTV.reloadSections([2], with: .none)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTVC()
        setUpTV()
        getFeedPostList(tagID: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(loadTagData), name: NSNotification.Name(rawValue: "sendTagData"), object: nil)
    }
}
// MARK: - Custom Methods
extension FeedMainVC {
    private func registerTVC() {
        FeedMainTitleTVC.register(target: feedTV)
        FeedMainEmptyTVC.register(target: feedTV)
        FeedMainPostTVC.register(target: feedTV)
    }
    
    private func setUpTV() {
        feedTV.contentInsetAdjustmentBehavior = .never
        feedTV.dataSource = self
        feedTV.delegate = self
    }
    
    @objc func loadTagData (_ notification : NSNotification)
    {
        let data = notification.object as? String ?? ""
        switch data {
        case "전체":
            getFeedPostList(tagID: 1)
        case "생활":
            getFeedPostList(tagID: 2)
        case "맛집":
            getFeedPostList(tagID: 3)
        case "꿀팁":
            getFeedPostList(tagID: 4)
        case "레시피":
            getFeedPostList(tagID: 5)
        case "기타":
            getFeedPostList(tagID: 6)
        default:
            break
        }
    }
}

// MARK: - UITableViewDelegate
extension FeedMainVC: UITableViewDelegate {
    
    /// section 2개로 나눔
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    /// cell 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 197.adjustedH
        } else if indexPath.section == 1 {
            return 55.adjustedH
        } else if indexPath.section == 2 {
            return 102.adjustedH
        } else {
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension FeedMainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return postList.count
        } else {
            return 0
        }
    }
    
    /// row에 들어갈 cell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let feedMainTitleTVC = tableView.dequeueReusableCell(withIdentifier: FeedMainTitleTVC.className) as? FeedMainTitleTVC,
              let feedMainEmptyTVC = tableView.dequeueReusableCell(withIdentifier: FeedMainEmptyTVC.className) as? FeedMainEmptyTVC,
              let feedMainPostTVC = tableView.dequeueReusableCell(withIdentifier: FeedMainPostTVC.className) as? FeedMainPostTVC else { return UITableViewCell() }
        if indexPath.section == 0 {
            feedMainTitleTVC.tapListBtnAction = {
                guard let myPostListVC = UIStoryboard.init(name: Identifiers.MyFeedPostSB, bundle: nil).instantiateViewController(withIdentifier: MyFeedPostVC.className) as? MyFeedPostVC else { return }
                
                self.navigationController?.pushViewController(myPostListVC, animated: true)
            }
            feedMainTitleTVC.tapWriteBtnAction = {
                guard let feedWriteVC = UIStoryboard.init(name: Identifiers.FeedWriteSB, bundle: nil).instantiateViewController(withIdentifier: FeedWriteVC.className) as? FeedWriteVC else { return }
                
                self.navigationController?.pushViewController(feedWriteVC, animated: true)
            }
            return feedMainTitleTVC
        } else if indexPath.section == 1 {
            return feedMainEmptyTVC
        } else if indexPath.section == 2 {
            feedMainPostTVC.setData(postData: postList[indexPath.row])
            return feedMainPostTVC
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - Network
extension FeedMainVC {
    
    /// 게시글 조회 메서드
    private func getFeedPostList(tagID: Int) {
        self.activityIndicator.startAnimating()
        FeedAPI.shared.getFeedListAPI(tagID: tagID) { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? [FeedListDataModel] {
                    DispatchQueue.main.async {
                        self.postList = data
                        self.feedTV.reloadSections([2], with: .none)
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
