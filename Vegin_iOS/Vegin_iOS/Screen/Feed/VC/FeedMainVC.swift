//
//  FeedMainVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/25.
//

import UIKit

class FeedMainVC: BaseVC {

    // MARK: Properties
    var postList: [FeedListDataModel] = []
    var categoryList = [String]()
    var selectedTagId: Int = 1
    
    let maxHeight: CGFloat = 215.0
    let minHeight: CGFloat = 55.0
    
    // MARK: IBOutlet
    @IBOutlet weak var feedTV: UITableView! {
        didSet {
            feedTV.contentInset = UIEdgeInsets(top: maxHeight, left: 0, bottom: 0, right: 0)
        }
    }
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var upperHeaderView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint! {
        didSet {
            heightConstraint.constant = maxHeight
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setUpTV()
        setUpCV()
        initDataList()
        setUpDefaultSelectedCategory()
        getFeedPostList(tagID: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getFeedPostList(tagID: selectedTagId)
    }
    
    @IBAction func tapMyFeedBtn(_ sender: UIButton) {
        guard let myPostListVC = UIStoryboard.init(name: Identifiers.MyFeedPostSB, bundle: nil).instantiateViewController(withIdentifier: MyFeedPostVC.className) as? MyFeedPostVC else { return }
        
        self.navigationController?.pushViewController(myPostListVC, animated: true)
    }
    
    @IBAction func tapWriteBtn(_ sender: UIButton) {
        guard let feedWriteVC = UIStoryboard.init(name: Identifiers.FeedWriteSB, bundle: nil).instantiateViewController(withIdentifier: FeedWriteVC.className) as? FeedWriteVC else { return }
        
        self.navigationController?.pushViewController(feedWriteVC, animated: true)
    }
    
}
// MARK: - Custom Methods
extension FeedMainVC {
    private func registerCell() {
        FeedMainPostTVC.register(target: feedTV)
        CategoryCVC.register(target: categoryCV)
    }
    
    private func setUpTV() {
        feedTV.contentInsetAdjustmentBehavior = .never
        feedTV.separatorColor = .clear
        feedTV.dataSource = self
        feedTV.delegate = self
    }
    
    private func setUpCV() {
        categoryCV.dataSource = self
        categoryCV.delegate = self
    }
    
    private func initDataList() {
        categoryList.append(contentsOf: [
            "전체", "생활", "맛집", "꿀팁", "레시피", "기타"
        ])
    }
    
    /// 디폴트로 선택된 카테고리 설정 함수
    private func setUpDefaultSelectedCategory() {
        self.categoryCV.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
    }

}

// MARK: - UITableViewDelegate
extension FeedMainVC: UITableViewDelegate {
    
    /// cell 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102.adjustedH
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0  {
            heightConstraint.constant = max(abs(scrollView.contentOffset.y), minHeight)
        } else if scrollView.contentOffset.y == 0.0 {
            heightConstraint.constant = maxHeight
        } else {
            heightConstraint.constant = minHeight
        }
    }
}

// MARK: - UITableViewDataSource
extension FeedMainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    /// row에 들어갈 cell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedMainPostTVC.className) as? FeedMainPostTVC else { return UITableViewCell() }
        
        cell.setData(postData: postList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let feedDetailVC = UIStoryboard.init(name: Identifiers.FeedDetailSB, bundle: nil).instantiateViewController(withIdentifier: FeedDetailVC.className) as? FeedDetailVC else { return }
        
        feedDetailVC.postId = postList[indexPath.row].postID
        self.navigationController?.pushViewController(feedDetailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedMainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: categoryList[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.PretendardSB(size: 14)!]).width + 31, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 21, bottom: 8, right: 21)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - UICollectionViewDataSource
extension FeedMainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
        
        cell.setCategoryData(categoryData: categoryList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTagId = indexPath.row + 1
        getFeedPostList(tagID: indexPath.row + 1)
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
                        self.feedTV.reloadData()
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
