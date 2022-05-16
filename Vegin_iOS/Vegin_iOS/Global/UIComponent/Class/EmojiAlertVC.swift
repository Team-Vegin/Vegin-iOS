//
//  EmojiAlertVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/06.
//

import UIKit

class EmojiAlertVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelBtn: VeginBtn! {
        didSet {
            cancelBtn.setTitleWithStyle(title: "취소", size: 12, weight: .bold)
            cancelBtn.isActivated = true
        }
    }
    
    // MARK: Properties
    var postId: Int = 0
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: IBAction
    @IBAction func tapCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tapEmoji1Btn(_ sender: UIButton) {
        postEmoji(postID: postId, emojiID: 1)
    }
    
    @IBAction func tapEmoji2Btn(_ sender: UIButton) {
        postEmoji(postID: postId, emojiID: 2)
    }
    
    @IBAction func tapEmoji3Btn(_ sender: UIButton) {
        postEmoji(postID: postId, emojiID: 3)
    }
    
    @IBAction func tapEmoji4Btn(_ sender: UIButton) {
        postEmoji(postID: postId, emojiID: 4)
    }
    
    @IBAction func tapEmoji5Btn(_ sender: UIButton) {
        postEmoji(postID: postId, emojiID: 5)
    }
    
    @IBAction func tapEmoji6Btn(_ sender: UIButton) {
        postEmoji(postID: postId, emojiID: 6)
    }
}

// MARK: - UI
extension EmojiAlertVC {
    private func configureUI() {
        alertView.makeRounded(cornerRadius: 20.adjusted)
    }
}

// MARK: - Custom Methods
extension EmojiAlertVC {
    func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("emojiBtnDidTap"), object: nil, userInfo: nil)
    }
}

// MARK: - Network
extension EmojiAlertVC {
    
    /// 이모지 달기, 취소 메서드
    private func postEmoji(postID: Int, emojiID: Int) {
        self.activityIndicator.startAnimating()
        FeedAPI.shared.postEmojiAPI(postID: postID, emojiID: emojiID) { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? FeedEmojiResModel {
                    print(data)
                    self.dismiss(animated: true)
                    self.postNotification()
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
