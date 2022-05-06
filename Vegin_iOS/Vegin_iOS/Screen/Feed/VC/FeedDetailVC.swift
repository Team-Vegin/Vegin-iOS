//
//  FeedDetailVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/12.
//

import UIKit

class FeedDetailVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
    
    /// 게시글 길이에 따른 동적 높이 셀 구현
    @IBOutlet weak var postTV: UITableView! {
        didSet {
            postTV.rowHeight = UITableView.automaticDimension
        }
    }
    @IBOutlet weak var naviRightBtn: UIButton!
    
    // MARK: Properties
    var postId: Int?
    var detailPost: FeedPostDataModel = FeedPostDataModel(postID: 0, title: "", content: "", tag: "", imageURL: "", createdAt: "", writer: Writer(userID: 0, nickname: "", profileImageID: 0))
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToNaviBar()
        registerTVC()
        setUpTV()
        getFeedDetailPost(postID: postId ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFeedDetailPost(postID: postId ?? 0)
    }
    
    // MARK: IBAction
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapRightNaviBtn(_ sender: UIButton) {
        makeTwoAlertWithCancel(okTitle: "수정하기", secondOkTitle: "삭제하기", okAction: { _ in
            self.sendDetailPostData()
        }, secondOkAction: { _ in
            guard let alert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC else { return }
            alert.showVeginAlert(vc: self, message: "글을 삭제하시겠습니까?", confirmBtnTitle: "확인", cancelBtnTitle: "취소", iconImg: "delete", type: .withDoubleBtn)
            alert.confirmBtn.press {
                self.deleteFeedPost(postID: self.postId ?? 0)
            }
            alert.cancelBtn.press {
                alert.dismiss(animated: true, completion: nil)
            }
        })
    }
}

// MARK: - UI
extension FeedDetailVC {
    private func setNaviRightBtn() {
        if UserDefaults.standard.integer(forKey: UserDefaults.Keys.UserID) != self.detailPost.writer.userID {
            self.naviRightBtn.isHidden = true
        } else {
            self.naviRightBtn.isHidden = false
        }
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
    
    /// 게시글 데이터 전달 위한 함수
    private func sendDetailPostData() {
        guard let feedWriteVC = UIStoryboard.init(name: Identifiers.FeedWriteSB, bundle: nil).instantiateViewController(withIdentifier: FeedWriteVC.className) as? FeedWriteVC else { return }
        
        var categoryID = 1
        if detailPost.tag == "생활" {
            categoryID = 2
        } else if detailPost.tag == "맛집" {
            categoryID = 3
        } else if detailPost.tag == "꿀팁" {
            categoryID = 4
        } else if detailPost.tag == "레시피" {
            categoryID = 5
        } else if detailPost.tag == "기타" {
            categoryID = 6
        }
        
        feedWriteVC.setReceivedData(status: false, postId: detailPost.postID, categoryId: categoryID, imageUrl: detailPost.imageURL, titleText: detailPost.title, contentText: detailPost.content)

        self.navigationController?.pushViewController(feedWriteVC, animated: true)
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
            feedDetailTitleTVC.titleLabel.sizeToFit()
            feedDetailTitleTVC.setData(postData: detailPost)
            return feedDetailTitleTVC
        } else if indexPath.section == 1 {
            feedDetailContentTVC.contentLabel.sizeToFit()
            feedDetailContentTVC.setData(postData: detailPost)
            return feedDetailContentTVC
        } else if indexPath.section == 2 {
            feedDetailEmojiTVC.tapPlusBtnAction = {
                guard let emojiPopUp = Bundle.main.loadNibNamed(EmojiAlertVC.className, owner: self, options: nil)?.first as? EmojiAlertVC else { return }
                
                emojiPopUp.modalTransitionStyle = .crossDissolve
                emojiPopUp.modalPresentationStyle = .overFullScreen
                self.present(emojiPopUp, animated: true)
            }
            return feedDetailEmojiTVC
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - Network
extension FeedDetailVC {
    
    /// 게시글 조회 메서드
    private func getFeedDetailPost(postID: Int) {
        self.activityIndicator.startAnimating()
        FeedAPI.shared.getFeedDetailPostAPI(postID: postID) { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? FeedPostDataModel {
                    print(data)
                    self.detailPost = data
                    self.postTV.reloadData()
                    self.setNaviRightBtn()
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
    
    /// 게시글 삭제 요청 메서드
    private func deleteFeedPost(postID: Int) {
        self.activityIndicator.startAnimating()
        FeedAPI.shared.deleteFeedPostAPI(postID: postID) { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? PostResModel {
                    print(data)
                    self.navigationController?.popViewController(animated: true)
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
