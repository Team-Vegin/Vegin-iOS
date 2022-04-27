//
//  WriteVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/16.
//

import UIKit

class WriteVC: BaseVC {
    
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
    var mealArray: [Int] = []
    var mealTime: Int = 0
    var mealAmount: Int = 0
    var selectedDate: String = ""
    var writeDate: String = ""
    let foodImgPicker = UIImagePickerController()
    private let placeholder = "메모를 입력하세요."
    
    // MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var foodImgView: UIImageView!
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
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        configureUI()
        addShadowToNaviBar()
        setUpDelegate()
        addKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func touchUpToGoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpToSaveButton(_ sender: UIButton) {
        createDietPost(image: foodImgView.image ?? UIImage(), meal: mealArray, mealTime: mealTime, amount: mealAmount, memo: memoTextView.text ?? "", date: writeDate)
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
        if isLevel1Selected {
            mealArray.append(1)
            mealArray.sort()
        } else {
            mealArray = mealArray.filter { $0 != 1 }
            mealArray.sort()
        }
    }
    @IBAction func touchUpLevel2Btn(_ sender: Any) {
        isLevel2Selected = !isLevel2Selected
        if isLevel2Selected {
            mealArray.append(2)
            mealArray.sort()
        } else {
            mealArray = mealArray.filter { $0 != 2 }
            mealArray.sort()
        }
    }
    
    @IBAction func touchUpLevel3Btn(_ sender: Any) {
        isLevel3Selected = !isLevel3Selected
        if isLevel3Selected {
            mealArray.append(3)
            mealArray.sort()
        } else {
            mealArray = mealArray.filter { $0 != 3 }
            mealArray.sort()
        }
    }
    @IBAction func touchUpLevel4Btn(_ sender: Any) {
        isLevel4Selected = !isLevel4Selected
        if isLevel4Selected {
            mealArray.append(4)
            mealArray.sort()
        } else {
            mealArray = mealArray.filter { $0 != 4 }
            mealArray.sort()
        }
    }
    @IBAction func touchUpLevel5Btn(_ sender: Any) {
        isLevel5Selected = !isLevel5Selected
        if isLevel5Selected {
            mealArray.append(5)
            mealArray.sort()
        } else {
            mealArray = mealArray.filter { $0 != 5 }
            mealArray.sort()
        }
    }
    @IBAction func touchUpLevel6Btn(_ sender: Any) {
        isLevel6Selected = !isLevel6Selected
        if isLevel6Selected {
            mealArray.append(6)
            mealArray.sort()
        } else {
            mealArray = mealArray.filter { $0 != 6 }
            mealArray.sort()
        }
    }
    
    @IBAction func touchUpMealButton(_ sender: UIButton) {
        if indexOfMeal != nil {
            if !sender.isSelected {
                for index in mealButtons.indices {
                    mealButtons[index].isSelected = false
                }
                sender.isSelected = true
                indexOfMeal = mealButtons.firstIndex(of: sender)
                mealTime = (indexOfMeal ?? 0) + 1 // 변수에 선택된 버튼인덱스 + 1  삽입
            } else {
                sender.isSelected = false
                indexOfMeal = nil
            }
        } else {
            sender.isSelected = true
            indexOfMeal = mealButtons.firstIndex(of: sender)
            mealTime = (indexOfMeal ?? 0) + 1
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
                mealAmount = (indexOfAmount ?? 0) + 1
            } else {
                sender.isSelected = false
                indexOfAmount = nil
            }
        } else {
            sender.isSelected = true
            indexOfAmount = amountButtons.firstIndex(of: sender)
            mealAmount = (indexOfAmount ?? 0) + 1
        }
        setUpSaveBtnStatus()
    }
    @IBAction func touchUpToShowImage(_ sender: Any) {
        makeTwoAlertWithCancelAndTitle(title: "이미지 업로드", message: "식단 사진을 업로드해주세요", okTitle: "사진앨범", secondOkTitle: "카메라", okAction: { _ in
            self.openLibrary()
        }, secondOkAction: { _ in
            self.openCamera()
        })
    }
}

// MARK: - UI
extension WriteVC {
    private func configureUI() {
        imageContentView.layer.cornerRadius = 25
        foodImgView.layer.cornerRadius = 25
        foodImgView.contentMode = .scaleAspectFill
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
            if indexOfMeal != nil && indexOfAmount != nil && imageUploadButton.tintColor == .clear {
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
        foodImgPicker.sourceType = .photoLibrary
        foodImgPicker.allowsEditing = true
        present(foodImgPicker, animated: false, completion: nil)
    }
    
    /// 카메라 불러오는 메소드
    private func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            foodImgPicker.sourceType = .camera
            foodImgPicker.allowsEditing = true
            present(foodImgPicker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension WriteVC: UINavigationControllerDelegate {
    
    /// 대리자 위임 메소드
    private func setUpDelegate() {
        foodImgPicker.delegate = self
        memoTextView.delegate = self
    }
}

// MARK: - UIImagePickerControllerDelegate
extension WriteVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        foodImgView.image = image
        imageUploadButton.tintColor = .clear
        setUpSaveBtnStatus()
        dismiss(animated: true, completion: nil)
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

// MARK: - Network
extension WriteVC {
    
    /// 식단 작성  메서드
    private func createDietPost(image: UIImage, meal: [Int], mealTime: Int, amount: Int, memo: String, date: String) {
        self.activityIndicator.startAnimating()
        DietAPI.shared.createDietPostAPI(image: image, meal: meal, mealTime: mealTime, amount: amount, memo: memo, date: date) { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
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
}

