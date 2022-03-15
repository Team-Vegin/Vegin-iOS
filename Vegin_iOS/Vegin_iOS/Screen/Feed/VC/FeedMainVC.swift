//
//  FeedMainVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/25.
//

import UIKit

class FeedMainVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var feedTV: UITableView!
    
    var postList: [FeedPostData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTVC()
        setUpTV()
        initPostList()
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
        feedTV.dataSource = self
        feedTV.delegate = self
    }
    
    private func initPostList() {
        postList.append(contentsOf: [
            FeedPostData(title: "맛있는 비건 식당 발견!", content: "최근 성북구에 갔다가 엄청 맛있는 비건 식당을 발견했어요! 가까우신 분들은 방문해서 다같이 비긴생활에 힘내셨으면 좋겠어요", nickName: "최은주", date: "2021.12.12", thumbnailImgName: "sample"),
            FeedPostData(title: "맛있는 비건 식당 발견!", content: "비건 식당 숨은 맛집 정말 많네요!", nickName: "최은주", date: "2021.12.12", thumbnailImgName: "sample"),
            FeedPostData(title: "기록 처음에는 귀찮았는데", content: "캐릭터 키우는 맛이 있네요~", nickName: "최은주", date: "2021.12.12", thumbnailImgName: "sample"),
            FeedPostData(title: "안녕하세요", content: "안녕안녕", nickName: "최은주", date: "2021.12.12", thumbnailImgName: "sample"),
            FeedPostData(title: "비긴 시작한 이전에는", content: "채소를 잘 안먹었지만...이제 먹으려고 노력중!!", nickName: "최은주", date: "2021.12.12", thumbnailImgName: "sample"),
            FeedPostData(title: "비긴 시작한 이전에는", content: "채소를 잘 안먹었지만...이제 먹으려고 노력중!!", nickName: "최은주", date: "2021.12.12", thumbnailImgName: "sample")
        ])
    }
    
    /// 화면 상단에 닿으면 스크롤 disable
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
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
