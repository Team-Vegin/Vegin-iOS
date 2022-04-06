//
//  FeedWriteVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/04/02.
//

import UIKit

class FeedWriteVC: BaseVC {
    
    var categoryArray: [Bool] = [false, false, false, false, false]
    var isCategory1Selected = false {
        didSet { setIconImage() }
    }
    var isCategory2Selected = false {
        didSet { setIconImage() }
    }
    var isCategory3Selected = false {
        didSet { setIconImage() }
    }
    var isCategory4Selected = false {
        didSet { setIconImage() }
    }
    var isCategory5Selected = false {
        didSet { setIconImage() }
    }
    
    var category: Int?
    let imgPicker = UIImagePickerController()
    private let titlePlaceholder = "제목을 입력해주세요 (13자 이내)"
    private let memoPlaceholder = "내용을 입력해주세요."
    
    //MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
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
            //saveBtn.isActivated = false
            //saveBtn.setTitleWithStyle(title: "저장하기", size: 16, weight: .semiBold)
        }
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: IBAction
    /// 뒤로가기
    @IBAction func tapNaviBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /// 사진 업로드
    @IBAction func tapImgUploadBtn(_ sender: Any) {
        makeTwoAlertWithCancelAndTitle(title: "이미지 업로드", message: "사진을 업로드해주세요", okTitle: "사진앨범", secondOkTitle: "카메라", okAction: { _ in
            self.openLibrary()
        }, secondOkAction: { _ in
            self.openCamera()
        })
    }
    /// 저장하기
    @IBAction func tapSaveBtn(_ sender: Any) {
        var imageCount = UserDefaults.standard.integer(forKey: "imageCount")
        imageCount += 1
        UserDefaults.standard.set(imageCount, forKey: "imageCount")
        
        categoryArray[0] = isCategory1Selected
        categoryArray[1] = isCategory2Selected
        categoryArray[2] = isCategory3Selected
        categoryArray[3] = isCategory4Selected
        categoryArray[4] = isCategory5Selected
        
        for i in 0...4 {
            if categoryArray[4-i] == true {
                UserDefaults.standard.set(5-i, forKey: "resultEmoji")
                break
            }
        }
        /// 작성 완료 창
        guard let alert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC else { return }
        alert.showVeginAlert(vc: self, message: "성공적으로\n작성되었습니다!", confirmBtnTitle: "확인")
        alert.confirmBtn.press {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// 선택 시 버튼 상태 변경
    func setIconImage() {
        if isCategory1Selected {
            categoryBtn1.setImage(UIImage.init(named: "life_selected"), for: .normal)
        } else if !isCategory1Selected {
            categoryBtn1.setImage(UIImage.init(named: "life"), for: .normal)
        }
        
        if isCategory2Selected {
            categoryBtn2.setImage(UIImage.init(named: "store_selected"), for: .normal)
        } else if !isCategory2Selected {
            categoryBtn2.setImage(UIImage.init(named: "store"), for: .normal)
        }
        
        if isCategory3Selected {
            categoryBtn3.setImage(UIImage.init(named: "tips_selected"), for: .normal)
        } else if !isCategory3Selected {
            categoryBtn3.setImage(UIImage.init(named: "tips"), for: .normal)
        }
        
        if isCategory4Selected {
            categoryBtn4.setImage(UIImage.init(named: "recipe_slected"), for: .normal)
        } else if !isCategory4Selected {
            categoryBtn4.setImage(UIImage.init(named: "recipe"), for: .normal)
        }
        
        if isCategory5Selected {
            categoryBtn5.setImage(UIImage.init(named: "ect_selected"), for: .normal)
        } else if !isCategory5Selected {
            categoryBtn5.setImage(UIImage.init(named: "etc"), for: .normal)
        }
        setUpSaveBtnStatus()
    }
    
    @IBAction func tapCategoryBtn1(_ sender: Any) {
    }
    @IBAction func tabCategoryBtn2(_ sender: Any) {
    }
    @IBAction func tabCategoryBtn3(_ sender: Any) {
    }
    @IBAction func tabCategoryBtn4(_ sender: Any) {
    }
    @IBAction func tabCategoryBtn5(_ sender: Any) {
    }
    
    //MARK: Custom Method
    /// 저장하기 버튼 상태 지정 메소드
    private func setUpSaveBtnStatus() {
        if isCategory1Selected || isCategory2Selected || isCategory3Selected || isCategory4Selected || isCategory5Selected  {
            if titleTextView != nil && memoTextView != nil {
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
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imgPicker.sourceType = .camera
            imgPicker.allowsEditing = true
            present(imgPicker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
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
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UITextViewDelegate
extension FeedWriteVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == titlePlaceholder {
            textView.text.removeAll()
            textView.textColor = .darkText
        }
        if textView.text == memoPlaceholder {
            textView.text.removeAll()
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !textView.hasText || textView.text == titlePlaceholder {
            textView.text = titlePlaceholder
            textView.textColor = .gray
        }
        if !textView.hasText || textView.text == memoPlaceholder {
            textView.text = memoPlaceholder
            textView.textColor = .gray
        }
    }
}