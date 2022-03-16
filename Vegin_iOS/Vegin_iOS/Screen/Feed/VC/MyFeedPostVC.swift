//
//  MyFeedPostVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/15.
//

import UIKit

class MyFeedPostVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var feedPostTV: UITableView!
    
    // MARK: Properties
    var feedMyPostList: [FeedMyPostListData] = []
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToNaviBar()
        registerTVC()
        setUpTV()
        initPostList()
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
        FeedMyPostTVC.register(target: feedPostTV)
    }
    
    private func setUpTV() {
        feedPostTV.delegate = self
        feedPostTV.dataSource = self
    }
    
    private func initPostList() {
        feedMyPostList.append(contentsOf: [
            FeedMyPostListData.init(title: "맛있는 비건 식당 발견!", content: "최근 성북구에 갔다가 엄청 맛있는 비건 식당을 발견했어요!가까우신 분들은 방문해서 다같이 비긴생활에 힘내셨으면 좋겠어요", nickName: "은주", date: "2021.12.12", category: "맛집", thumbnailImgName: "sample"),
            FeedMyPostListData.init(title: "플렉시테리언이 제일 낫다", content: "일주일에 고기 한두 번 먹어도 양심에 안 찔리는 ㅎ", nickName: "은주", date: "2021.12.14", category: "생활", thumbnailImgName: "Rectangle 419"),
            FeedMyPostListData.init(title: "오늘 비긴 했나요?", content: "사진 찍을 때마다 조금 귀찮지만\n힘내 보는 중...", nickName: "은주", date: "2021.12.17", category: "생활", thumbnailImgName: "Rectangle 419"),
            FeedMyPostListData.init(title: "비건 식당 많이 생겼음 좋겠다", content: "제발... 이렇게 원해...", nickName: "은주", date: "2022.01.12", category: "생활", thumbnailImgName: "Rectangle 419"),
            FeedMyPostListData.init(title: "제일 좋아하는 젤리 못 먹다니", content: "비건도 하면서 같이 다이어트 식단도 병행하니까\n군것질 하기가 넘 힘드네요 ㅠ\n잘 참아 봅니다... 오늘도 ㅠㅠ", nickName: "은주", date: "2022.01.18", category: "생활", thumbnailImgName: "Rectangle 419"),
            FeedMyPostListData.init(title: "레시피 공유합니다~", content: "제가 요즘 즐겨먹는 샐러드 레시피 소개해드릴게요!", nickName: "은주", date: "2022.03.01", category: "레시피", thumbnailImgName: "Rectangle 293"),
        ])
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
              let cell = tableView.dequeueReusableCell(withIdentifier: FeedMyPostTVC.className) as? FeedMyPostTVC else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            return emptyCell
        } else if indexPath.section == 1 {
            cell.setData(postData: feedMyPostList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
