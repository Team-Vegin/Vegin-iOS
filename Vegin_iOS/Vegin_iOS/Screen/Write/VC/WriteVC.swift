//
//  WriteVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/16.
//

import UIKit
import FirebaseStorage

class WriteVC: BaseVC, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let storage = Storage.storage().reference() // 인스턴스 생성
    var emojiArray: [Bool] = [false,false,false,false,false,false]
    
    var isLevel1Selected = false {
        didSet {
            setIconImage()
        }
    }
    var isLevel2Selected = false {
        didSet {
            setIconImage()
        }
    }
    var isLevel3Selected = false {
        didSet {
            setIconImage()
        }
    }
    var isLevel4Selected = false {
        didSet {
            setIconImage()
        }
    }
    var isLevel5Selected = false {
        didSet {
            setIconImage()
        }
    }
    var isLevel6Selected = false {
        didSet {
            setIconImage()
        }
    }
    
    var indexOfMeal: Int?
    var indexOfAmount: Int?
    let picker = UIImagePickerController()
    private let placeholder = "메모를 입력하세요."
    
    // MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var level1Button: UIButton!
    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var level3Button: UIButton!
    @IBOutlet weak var level4Button: UIButton!
    @IBOutlet weak var level5Button: UIButton!
    @IBOutlet weak var level6Button: UIButton!
    @IBOutlet weak var imageUploadButton: UIButton!
    @IBOutlet var mealButtons: [UIButton]!
    @IBOutlet var amountButtons: [UIButton]!
    @IBOutlet weak var saveBtn: VeginBtn! {
        didSet {
            saveBtn.isActivated = false
            saveBtn.setTitleWithStyle(title: "저장하기", size: 16, weight: .semiBold)
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        configureUI()
        addShadowToNaviBar()
        addKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func touchUpToGoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpToSaveButton(_ sender: UIButton) {
        var imageCount = UserDefaults.standard.integer(forKey: "imageCount")
        imageCount += 1
        UserDefaults.standard.set(imageCount, forKey: "imageCount")
        
        emojiArray[0] = isLevel1Selected
        emojiArray[1] = isLevel2Selected
        emojiArray[2] = isLevel3Selected
        emojiArray[3] = isLevel4Selected
        emojiArray[4] = isLevel5Selected
        emojiArray[5] = isLevel6Selected
        
        for i in 0...5 {
            if emojiArray[5-i] == true {
                UserDefaults.standard.set(5-i, forKey: "resultEmoji")
                break
            }
        }
        
        let resultEmoji = UserDefaults.standard.integer(forKey: "resultEmoji")

        var calendarEmoji: [String:Any] = UserDefaults.standard.dictionary(forKey: "calendarEmoji") ?? [:]

        calendarEmoji.updateValue(resultEmoji, forKey: "\(getDayDate(date: Date()))")
        UserDefaults.standard.set(calendarEmoji, forKey: "calendarEmoji")
        print(UserDefaults.standard.dictionary(forKey: "calendarEmoji"))
        
        guard let alert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC else { return }
        alert.showVeginAlert(vc: self, message: "성공적으로\n작성되었습니다!", confirmBtnTitle: "확인")
        alert.confirmBtn.press {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setIconImage() {
        if isLevel1Selected {
            level1Button.setImage(UIImage.init(named: "level1_select"), for: .normal)
        } else if !isLevel1Selected {
            level1Button.setImage(UIImage.init(named: "brocoli"), for: .normal)
        }
        
        if isLevel2Selected {
            level2Button.setImage(UIImage.init(named: "level2_select"), for: .normal)
        } else if !isLevel2Selected {
            level2Button.setImage(UIImage.init(named: "milk"), for: .normal)
        }
        
        if isLevel3Selected {
            level3Button.setImage(UIImage.init(named: "level3_select"), for: .normal)
        } else if !isLevel3Selected {
            level3Button.setImage(UIImage.init(named: "egg"), for: .normal)
        }
        
        if isLevel4Selected {
            level4Button.setImage(UIImage.init(named: "level4_select"), for: .normal)
        } else if !isLevel4Selected {
            level4Button.setImage(UIImage.init(named: "fish"), for: .normal)
        }
        
        if isLevel5Selected {
            level5Button.setImage(UIImage.init(named: "level5_select"), for: .normal)
        } else if !isLevel5Selected {
            level5Button.setImage(UIImage.init(named: "chicken"), for: .normal)
        }
        
        if isLevel6Selected {
            level6Button.setImage(UIImage.init(named: "level6_select"), for: .normal)
            
        } else if !isLevel6Selected {
            level6Button.setImage(UIImage.init(named: "meat"), for: .normal)
        }
        setUpSaveBtnStatus()
    }
    
    @IBAction func touchUpLevel1Btn(_ sender: Any) {
        isLevel1Selected = !isLevel1Selected
    }
    @IBAction func touchUpLevel2Btn(_ sender: Any) {
        isLevel2Selected = !isLevel2Selected
    }
    
    @IBAction func touchUpLevel3Btn(_ sender: Any) {
        isLevel3Selected = !isLevel3Selected
    }
    @IBAction func touchUpLevel4Btn(_ sender: Any) {
        isLevel4Selected = !isLevel4Selected
    }
    @IBAction func touchUpLevel5Btn(_ sender: Any) {
        isLevel5Selected = !isLevel5Selected
    }
    @IBAction func touchUpLevel6Btn(_ sender: Any) {
        isLevel6Selected = !isLevel6Selected
    }
    
    @IBAction func touchUpMealButton(_ sender: UIButton) {
        if indexOfMeal != nil {
            if !sender.isSelected {
                for index in mealButtons.indices {
                    mealButtons[index].isSelected = false
                }
                sender.isSelected = true
                indexOfMeal = mealButtons.firstIndex(of: sender)
            } else {
                sender.isSelected = false
                indexOfMeal = nil
            }
        } else {
            sender.isSelected = true
            indexOfMeal = mealButtons.firstIndex(of: sender)
        }
        setUpSaveBtnStatus()
    }
    
    @IBAction func touchUpAmountButton(_ sender: UIButton) {
        if indexOfAmount != nil {
            if !sender.isSelected {
                for index in amountButtons.indices {
                    amountButtons[index].isSelected = false
                }
                sender.isSelected = true
                indexOfAmount = amountButtons.firstIndex(of: sender)
            } else {
                sender.isSelected = false
                indexOfAmount = nil
            }
        } else {
            sender.isSelected = true
            indexOfAmount = amountButtons.firstIndex(of: sender)
        }
        setUpSaveBtnStatus()
    }
    @IBAction func touchUpToShowImage(_ sender: Any) {
        let alert = UIAlertController(title: "이미지 업로드", message: "식단 사진을 업로드해주세요", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }
        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }

        guard let imageData = image.pngData() else {
            return
        }
        
        storage.child("images/file\(UserDefaults.standard.integer(forKey: "imageCount")).png").putData(imageData, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }

        })
        imageView.image = image
        imageUploadButton.tintColor = .clear
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI
extension WriteVC {
    private func configureUI() {
        picker.delegate = self
        memoTextView.delegate = self
        
        imageContentView.layer.cornerRadius = 25
        imageView.layer.cornerRadius = 25
        saveBtn.makeRounded(cornerRadius: 0.5 * saveBtn.bounds.size.height)
        mealButtons[0].setImage(UIImage.init(named: "select"), for: .selected)
        mealButtons[0].setImage(UIImage.init(named: "breakfast"), for: .normal)
        mealButtons[1].setImage(UIImage.init(named: "select-4"), for: .selected)
        mealButtons[1].setImage(UIImage.init(named: "brunch"), for: .normal)
        mealButtons[2].setImage(UIImage.init(named: "select-2"), for: .selected)
        mealButtons[2].setImage(UIImage.init(named: "lunch"), for: .normal)
        mealButtons[3].setImage(UIImage.init(named: "select-3"), for: .selected)
        mealButtons[3].setImage(UIImage.init(named: "lundinner"), for: .normal)
        mealButtons[4].setImage(UIImage.init(named: "select-1"), for: .selected)
        mealButtons[4].setImage(UIImage.init(named: "dinner"), for: .normal)
        amountButtons[0].setImage(UIImage.init(named: "little-select"), for: .selected)
        amountButtons[0].setImage(UIImage.init(named: "little"), for: .normal)
        amountButtons[1].setImage(UIImage.init(named: "medium-select"), for: .selected)
        amountButtons[1].setImage(UIImage.init(named: "medium"), for: .normal)
        amountButtons[2].setImage(UIImage.init(named: "much-select"), for: .selected)
        amountButtons[2].setImage(UIImage.init(named: "much"), for: .normal)
        [mealButtons[0], mealButtons[1], mealButtons[2], mealButtons[3], mealButtons[4], amountButtons[0], amountButtons[1], amountButtons[2]].forEach {
            btn in btn?.tintColor = .white
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
extension WriteVC {
    
    /// 저장하기 버튼 상태 지정 메소드
    private func setUpSaveBtnStatus() {
        if isLevel1Selected || isLevel2Selected || isLevel3Selected || isLevel4Selected || isLevel5Selected || isLevel6Selected {
            if indexOfMeal != nil && indexOfAmount != nil {
                self.saveBtn.isActivated = true
            } else {
                self.saveBtn.isActivated = false
            }
        } else {
            self.saveBtn.isActivated = false
        }
    }
}

// MARK: - UITextViewDelegate
extension WriteVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text.removeAll()
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !textView.hasText || textView.text == placeholder {
            textView.text = placeholder
            textView.textColor = .gray
        }
    }
}

// MARK: - Keyboard
extension WriteVC {
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

