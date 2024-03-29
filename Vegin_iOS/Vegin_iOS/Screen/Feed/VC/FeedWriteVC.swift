//
//  FeedWriteVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/04/02.
//

import UIKit
import Kingfisher

class FeedWriteVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var naviTitle: UILabel!
    @IBOutlet weak var feedImgView: UIImageView!
    @IBOutlet weak var imgContentView: UIView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var imgUploadBtn: UIButton!
    @IBOutlet weak var categoryBtn1: UIButton!
    @IBOutlet weak var categoryBtn2: UIButton!
    @IBOutlet weak var categoryBtn3: UIButton!
    @IBOutlet weak var categoryBtn4: UIButton!
    @IBOutlet weak var categoryBtn5: UIButton!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var saveBtn: VeginBtn! {
        didSet {
            saveBtn.isActivated = false
            saveBtn.setTitleWithStyle(title: "작성 완료", size: 16, weight: .semiBold)
        }
    }
    
    // MARK: Properties
    private let imgPicker = UIImagePickerController()
    private let titlePlaceholder = "제목을 입력해주세요"
    private let memoPlaceholder = "내용을 입력해주세요"
    private var categoryID: Int = 0
    
    /// 게시글 수정 기능 위한 변수
    private var postID: Int = -1
    private var isWriting: Bool = true // 작성, 수정 판별 위한 변수
    private var titleData: String = ""
    private var contentData: String = ""
    private var imageURL: URL?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleTextView.delegate = self
        self.memoTextView.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        configureUI()
        setUpDelegate()
        setUpSaveBtnStatus()
        addKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: IBAction
    @IBAction func tapNaviBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func tapImgUploadBtn(_ sender: Any) {
        makeTwoAlertWithCancelAndTitle(title: "이미지 업로드", message: "사진을 업로드해주세요", okTitle: "사진앨범", secondOkTitle: "카메라", okAction: { _ in
            self.openLibrary()
        }, secondOkAction: { _ in
            self.openCamera()
        })
    }
    
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        if isWriting {
            createFeedPost(image: feedImgView.image ?? UIImage(), title: titleTextView.text ?? "", content: memoTextView.text ?? "" , tagID: categoryID)
        } else {
            editFeedPost(postID: postID, image: feedImgView.image ?? UIImage(), title: titleTextView.text ?? "", content: memoTextView.text ?? "", tagID: categoryID)
        }
    }
    
    @IBAction func tapCategoryBtn1(_ sender: UIButton) {
        categoryBtn1.isSelected.toggle()
        [categoryBtn2, categoryBtn3, categoryBtn4, categoryBtn5].forEach {
            btn in btn?.isSelected = false
        }
        [categoryBtn1, categoryBtn2, categoryBtn3, categoryBtn4, categoryBtn5].forEach {
            configureBtnUI(btn: $0)
        }
        categoryID = 2
        setUpSaveBtnStatus()
    }
    
    @IBAction func tabCategoryBtn2(_ sender: UIButton) {
        categoryBtn2.isSelected.toggle()
        [categoryBtn1, categoryBtn3, categoryBtn4, categoryBtn5].forEach {
            btn in btn?.isSelected = false
        }
        [categoryBtn1, categoryBtn2, categoryBtn3, categoryBtn4, categoryBtn5].forEach {
            configureBtnUI(btn: $0)
        }
        categoryID = 3
        setUpSaveBtnStatus()
    }
    
    @IBAction func tabCategoryBtn3(_ sender: UIButton) {
        categoryBtn3.isSelected.toggle()
        [categoryBtn1, categoryBtn2, categoryBtn4, categoryBtn5].forEach {
            btn in btn?.isSelected = false
        }
        [categoryBtn1, categoryBtn2, categoryBtn3, categoryBtn4, categoryBtn5].forEach {
            configureBtnUI(btn: $0)
        }
        categoryID = 4
        setUpSaveBtnStatus()
    }
    
    @IBAction func tabCategoryBtn4(_ sender: UIButton) {
        categoryBtn4.isSelected.toggle()
        [categoryBtn1, categoryBtn2, categoryBtn3, categoryBtn5].forEach {
            btn in btn?.isSelected = false
        }
        [categoryBtn1, categoryBtn2, categoryBtn3, categoryBtn4, categoryBtn5].forEach {
            configureBtnUI(btn: $0)
        }
        categoryID = 5
        setUpSaveBtnStatus()
    }
    
    @IBAction func tabCategoryBtn5(_ sender: UIButton) {
        categoryBtn5.isSelected.toggle()
        [categoryBtn1, categoryBtn2, categoryBtn3, categoryBtn4].forEach {
            btn in btn?.isSelected = false
        }
        [categoryBtn1, categoryBtn2, categoryBtn3, categoryBtn4, categoryBtn5].forEach {
            configureBtnUI(btn: $0)
        }
        categoryID = 6
        setUpSaveBtnStatus()
    }
    
    //MARK: - Custom Method
    
    /// 카테고리 버튼 UI 설정 메서드
    private func configureBtnUI(btn: UIButton) {
        if btn.isSelected {
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = .darkMain
        } else {
            btn.setTitleColor(.defaultTextGray, for: .normal)
            btn.backgroundColor = .defaultGray
        }
    }
    
    /// 저장하기 버튼 상태 지정 메서드
    private func setUpSaveBtnStatus() {
        if categoryBtn1.isSelected  || categoryBtn2.isSelected || categoryBtn3.isSelected || categoryBtn4.isSelected || categoryBtn5.isSelected  {
            if titleTextView.hasText && titleTextView.text != titlePlaceholder && memoTextView.hasText && memoTextView.text != memoPlaceholder && imgUploadBtn.tintColor == .clear {
                self.saveBtn.isActivated = true
            } else {
                self.saveBtn.isActivated = false
            }
        } else {
            self.saveBtn.isActivated = false
        }
    }
    
    /// 사진앨범 불러오는 메소드
    private func openLibrary() {
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        present(imgPicker, animated: false, completion: nil)
    }
    
    /// 카메라 불러오는 메소드
    private func openCamera() {
        if (UIImagePickerController .isSourceTypeAvailable(.camera)) {
            imgPicker.sourceType = .camera
            imgPicker.allowsEditing = true
            present(imgPicker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
    }
    
    /// FeedDetailVC에서 상태값 받아오기 위한 함수
    func setReceivedData(status: Bool, postId: Int, categoryId: Int, imageUrl: String, titleText: String, contentText: String) {
        isWriting = status
        postID = postId
        categoryID = categoryId
        imageURL = URL(string: imageUrl)
        titleData = titleText
        contentData = contentText
    }
}
// MARK: - UI
extension FeedWriteVC {
    private func configureUI() {
        [categoryBtn1, categoryBtn2, categoryBtn3, categoryBtn4, categoryBtn5].forEach { btn in
            btn?.makeRounded(cornerRadius: 0.5 * (btn?.bounds.size.height ?? 30))
            btn?.isSelected = false
        }
        imgContentView.layer.cornerRadius = 25
        feedImgView.layer.cornerRadius = 25
        feedImgView.contentMode = .scaleAspectFill
        saveBtn.makeRounded(cornerRadius: 0.5 * saveBtn.bounds.size.height)
        
        /// 게시글 수정 시
        if !isWriting {
            naviTitle.text = "게시글 수정"
            titleTextView.textColor = .darkMain
            titleTextView.text = titleData
            memoTextView.textColor = .darkText
            memoTextView.text = contentData
            feedImgView.kf.setImage(with: imageURL)
            imgUploadBtn.tintColor = .clear
            
            if categoryID == 2 {
                categoryBtn1.isSelected = true
            } else if categoryID == 3 {
                categoryBtn2.isSelected = true
            } else if categoryID == 4 {
                categoryBtn3.isSelected = true
            } else if categoryID == 5 {
                categoryBtn4.isSelected = true
            } else if categoryID == 6 {
                categoryBtn5.isSelected = true
            }
            [categoryBtn1, categoryBtn2, categoryBtn3, categoryBtn4, categoryBtn5].forEach {
                configureBtnUI(btn: $0)
            }
        }
    }
}

// MARK: UINavigationControllerDelegate
extension FeedWriteVC: UINavigationControllerDelegate {
    
    /// 대리자 위임 메소드
    private func setUpDelegate() {
        imgPicker.delegate = self
        titleTextView.delegate = self
        memoTextView.delegate = self
    }
}

// MARK: UIImagePickerControllerDelegate
extension FeedWriteVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        feedImgView.image = image
        imgUploadBtn.tintColor = .clear
        setUpSaveBtnStatus()
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UITextViewDelegate
extension FeedWriteVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           if textView == titleTextView && text == "\n" {
               titleTextView.resignFirstResponder()
               return false
           }
           return true
       }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == titleTextView && titleTextView.text == titlePlaceholder {
            titleTextView.text.removeAll()
            titleTextView.textColor = .darkMain
        } else if textView == memoTextView && memoTextView.text == memoPlaceholder {
            memoTextView.text.removeAll()
            memoTextView.textColor = .black
        }
        setUpSaveBtnStatus()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !titleTextView.hasText || titleTextView.text == titlePlaceholder {
            titleTextView.text = titlePlaceholder
            titleTextView.textColor = .gray
        }
        
        if !memoTextView.hasText || memoTextView.text == memoPlaceholder {
            memoTextView.text = memoPlaceholder
            memoTextView.textColor = .gray
        }
        setUpSaveBtnStatus()
    }
}

// MARK: - Keyboard
extension FeedWriteVC {
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }
}

// MARK: - Network
extension FeedWriteVC {
    
    /// 게시글 작성 메서드
    private func createFeedPost(image: UIImage, title: String, content: String, tagID: Int) {
        self.activityIndicator.startAnimating()
        FeedAPI.shared.createFeedPostAPI(image: image, title: title, content: content, tagID: tagID) { networkResult in
            switch networkResult {
            case .success(let res):
                self.activityIndicator.stopAnimating()
                print(res)
                guard let alert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC else { return }
                alert.showVeginAlert(vc: self, message: "성공적으로\n작성되었습니다!", confirmBtnTitle: "확인", cancelBtnTitle: "", iconImg: "cheerUp", type: .withSingleBtn)
                alert.confirmBtn.press {
                    self.navigationController?.popViewController(animated: true)
                }
            case .requestErr(let res):
                self.activityIndicator.stopAnimating()
                print(res)
            default:
                self.activityIndicator.stopAnimating()
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
    
    /// 게시글 수정 메서드
    private func editFeedPost(postID: Int, image: UIImage, title: String, content: String, tagID: Int) {
        self.activityIndicator.startAnimating()
        FeedAPI.shared.editFeedPostAPI(postID: postID, image: image, title: title, content: content, tagID: tagID) { networkResult in
            switch networkResult {
            case .success(let res):
                self.activityIndicator.stopAnimating()
                print(res)
                guard let alert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC else { return }
                alert.showVeginAlert(vc: self, message: "성공적으로\n수정되었습니다!", confirmBtnTitle: "확인", cancelBtnTitle: "", iconImg: "cheerUp", type: .withSingleBtn)
                alert.confirmBtn.press {
                    self.navigationController?.popViewController(animated: true)
                }
            case .requestErr(let res):
                self.activityIndicator.stopAnimating()
                print(res)
            default:
                self.activityIndicator.stopAnimating()
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}

