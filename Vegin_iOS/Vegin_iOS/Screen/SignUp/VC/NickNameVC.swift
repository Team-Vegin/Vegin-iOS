//
//  NickNameVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/28.
//

import UIKit

class NickNameVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameInfoLabel: UILabel!
    @IBOutlet weak var flexiterianBtn: UIButton!
    @IBOutlet weak var nickNameCheckBtn: VeginBtn! {
        didSet {
            nickNameCheckBtn.isActivated = false
            nickNameCheckBtn.setTitleWithStyle(title: "중복확인", size: 12, weight: .bold)
        }
    }
    @IBOutlet weak var polloBtn: UIButton!
    @IBOutlet weak var pescoBtn: UIButton!
    @IBOutlet weak var lactoOvoBtn: UIButton!
    @IBOutlet weak var lactoBtn: UIButton!
    @IBOutlet weak var veganBtn: UIButton!
    @IBOutlet weak var notYetBtn: UIButton!
    @IBOutlet weak var brocoliImgView: UIImageView!
    @IBOutlet weak var milkImgView: UIImageView!
    @IBOutlet weak var eggImgView: UIImageView!
    @IBOutlet weak var fishImgView: UIImageView!
    @IBOutlet weak var chickenImgView: UIImageView!
    @IBOutlet weak var meatImgView: UIImageView!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var startBtn: VeginBtn! {
        didSet {
            startBtn.isActivated = false
            startBtn.setTitleWithStyle(title: "Vegin 시작하기!", size: 16, weight: .bold)
        }
    }
    
    // MARK: Properties
    var email: String?
    var password: String?
    var orientation: String?
    private var isValidNickName = false
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpDelegate()
    }
    
    // MARK: IBAction
    @IBAction func tapNickNameCheckBtn(_ sender: UIButton) {
        requestCheckNickName(nickname: nickNameTextField.text ?? "")
    }
    
    @IBAction func tapFlexiterianBtn(_ sender: UIButton) {
        flexiterianBtn.isSelected.toggle()
        [polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
        [brocoliImgView, milkImgView, eggImgView, fishImgView, chickenImgView, meatImgView].forEach {
            img in setImg(img: img, status: flexiterianBtn.isSelected)
        }
        orientation = "Flexiterian"
        setExplanationLabel()
        setStartBtnStatus()
    }
    
    @IBAction func tapPolloBtn(_ sender: UIButton) {
        polloBtn.isSelected.toggle()
        [flexiterianBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
        [brocoliImgView, milkImgView, eggImgView, fishImgView, chickenImgView].forEach {
            img in setImg(img: img, status: polloBtn.isSelected)
        }
        setImg(img: meatImgView, status: false)
        orientation = "Pollo"
        setExplanationLabel()
        setStartBtnStatus()
    }
    
    @IBAction func tapPescoBtn(_ sender: UIButton) {
        pescoBtn.isSelected.toggle()
        [flexiterianBtn, polloBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
        [brocoliImgView, milkImgView, eggImgView, fishImgView].forEach {
            img in setImg(img: img, status: pescoBtn.isSelected)
        }
        [chickenImgView, meatImgView].forEach {
            img in setImg(img: img, status: false)
        }
        orientation = "Pesco"
        setExplanationLabel()
        setStartBtnStatus()
    }
    
    @IBAction func tapLactoOvoBtn(_ sender: UIButton) {
        lactoOvoBtn.isSelected.toggle()
        [flexiterianBtn, polloBtn, pescoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
        [brocoliImgView, milkImgView, eggImgView].forEach {
            img in setImg(img: img, status: lactoOvoBtn.isSelected)
        }
        [fishImgView, chickenImgView, meatImgView].forEach {
            img in setImg(img: img, status: false)
        }
        orientation = "Lacto-Ovo"
        setExplanationLabel()
        setStartBtnStatus()
    }
    
    @IBAction func tapLactoBtn(_ sender: UIButton) {
        lactoBtn.isSelected.toggle()
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, veganBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
        [brocoliImgView, milkImgView].forEach {
            img in setImg(img: img, status: lactoBtn.isSelected)
        }
        [eggImgView, fishImgView, chickenImgView, meatImgView].forEach {
            img in setImg(img: img, status: false)
        }
        orientation = "Lacto"
        setExplanationLabel()
        setStartBtnStatus()
    }
    
    @IBAction func tapVeganBtn(_ sender: UIButton) {
        veganBtn.isSelected.toggle()
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
        setImg(img: brocoliImgView, status: veganBtn.isSelected)
        [milkImgView, eggImgView, fishImgView, chickenImgView, meatImgView].forEach {
            img in setImg(img: img, status: false)
        }
        orientation = "Vegan"
        setExplanationLabel()
        setStartBtnStatus()
    }
    
    @IBAction func tapNotYetBtn(_ sender: UIButton) {
        notYetBtn.isSelected.toggle()
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
        [brocoliImgView, milkImgView, eggImgView, fishImgView, chickenImgView, meatImgView].forEach {
            img in setImg(img: img, status: notYetBtn.isSelected)
        }
        orientation = "Flexiterian"
        setExplanationLabel()
        setStartBtnStatus()
    }
    
    @IBAction func tapStartBtn(_ sender: UIButton) {
        requestSignUp(email: self.email ?? "", pw: self.password ?? "", nickname: nickNameTextField.text ?? "", orientation: self.orientation ?? "")
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapDismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UI
extension NickNameVC {
    private func configureUI() {
        nickNameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해 주세요. (최대 12자)", attributes: [NSAttributedString.Key.font: UIFont.PretendardR(size: 14)!])
        nickNameInfoLabel.text = ""
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach { btn in btn?.backgroundColor = .white
            btn?.makeRounded(cornerRadius: 0.5 * (btn?.bounds.size.height)!)
            btn?.layer.borderColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 0.5).cgColor
            btn?.layer.borderWidth = 1
        }
    }
    
    /// 버튼 UI 설정해주는 함수
    private func configureBtnUI(btn: UIButton, btnBgColor: UIColor, btnTitleColor: UIColor, btnBorderColor: CGColor) {
        btn.backgroundColor = btnBgColor
        btn.setTitleColor(btnTitleColor, for: .normal)
        btn.layer.borderColor = btnBorderColor
    }
}

// MARK: - Custom Methods
extension NickNameVC {
    private func setUpDelegate() {
        nickNameTextField.delegate = self
        nickNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    /// 버튼 상태에 따른 UI 설정 함수
    private func setBtnStatus(btn: UIButton) {
        if btn.isSelected {
            configureBtnUI(btn: btn, btnBgColor: .darkMain, btnTitleColor: .white, btnBorderColor: UIColor.darkMain.cgColor)
        } else {
            configureBtnUI(btn: btn, btnBgColor: .white, btnTitleColor: .gray0, btnBorderColor: UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 0.5).cgColor)
        }
    }
    
    private func setStartBtnStatus() {
        if isValidNickName && (flexiterianBtn.isSelected || polloBtn.isSelected || pescoBtn.isSelected || lactoOvoBtn.isSelected || lactoBtn.isSelected || veganBtn.isSelected || notYetBtn.isSelected) {
            startBtn.isActivated = true
        } else {
            startBtn.isActivated = false
        }
    }
    
    /// 버튼 상태에 따른 이미지 설정 함수
    private func setImg(img: UIImageView, status: Bool) {
        if img == brocoliImgView {
            if status {
                brocoliImgView.image = UIImage.init(named: "level1_select")
            } else {
                brocoliImgView.image = UIImage.init(named: "brocoli")
            }
        }
        
        if img == milkImgView {
            if status {
                milkImgView.image = UIImage.init(named: "level2_select")
            } else {
                milkImgView.image = UIImage.init(named: "milk")
            }
        }
        
        if img == eggImgView {
            if status {
                eggImgView.image = UIImage.init(named: "level3_select")
            } else {
                eggImgView.image = UIImage.init(named: "egg")
            }
        }
        
        if img == fishImgView {
            if status {
                fishImgView.image = UIImage.init(named: "level4_select")
            } else {
                fishImgView.image = UIImage.init(named: "fish")
            }
        }
        
        if img == chickenImgView {
            if status {
                chickenImgView.image = UIImage.init(named: "level5_select")
            } else {
                chickenImgView.image = UIImage.init(named: "chicken")
            }
        }
        
        if img == meatImgView {
            if status {
                meatImgView.image = UIImage.init(named: "level6_select")
            } else {
                meatImgView.image = UIImage.init(named: "meat")
            }
        }
    }
    
    /// 비건 지향성 설명 Label 설정 함수
    private func setExplanationLabel() {
        if !flexiterianBtn.isSelected && !polloBtn.isSelected && !pescoBtn.isSelected && !lactoOvoBtn.isSelected && !lactoBtn.isSelected && !veganBtn.isSelected && !notYetBtn.isSelected {
            explanationLabel.text = "평상시 섭취하는 음식을 선택하세요."
        } else if flexiterianBtn.isSelected {
            explanationLabel.text = "채식을 실천하지만 상황에 따라 육식을 해요."
        } else if polloBtn.isSelected {
            explanationLabel.text = "동물성 원료 중 닭까지 섭취해요 소고기와 돼지는 No!"
        } else if pescoBtn.isSelected {
            explanationLabel.text = "소, 닭, 돼지, 오리 등 육지 동물을 섭취하지 않지만, 해산물은 섭취해요."
        } else if lactoOvoBtn.isSelected {
            explanationLabel.text = "채소와 우유, 달걀만 섭취할 수 있어요."
        } else if lactoBtn.isSelected {
            explanationLabel.text = "동물성 원료 중 우유까지 섭취할 수 있어요."
        } else if veganBtn.isSelected {
            explanationLabel.text = "윤리적인 이유로 모든 동물성 원료를 거부해요!"
        } else if notYetBtn.isSelected {
            explanationLabel.text = "채식을 실천하지만 상황에 따라 육식을 하는 것을 추천해요."
        }
    }
}

// MARK: - UITextFieldDelegate
extension NickNameVC: UITextFieldDelegate {
    @objc
    func textFieldDidChange(_ sender: Any?) {
        nickNameInfoLabel.text = ""
        isValidNickName = false
        setStartBtnStatus()
        
        if !nickNameTextField.isEmpty {
            nickNameCheckBtn.isActivated = true
        } else {
            nickNameCheckBtn.isActivated = false
        }
    }
}

// MARK: - Network
extension NickNameVC {
    
    /// 닉네임 중복 확인 메서드
    private func requestCheckNickName(nickname: String) {
        self.activityIndicator.startAnimating()
        SignAPI.shared.checkNickNameDuplicateAPI(nickname: nickname) { networkResult in
            switch networkResult {
            case .success:
                self.activityIndicator.stopAnimating()
                self.nickNameInfoLabel.textColor = .darkMain
                self.nickNameInfoLabel.text = "사용 가능한 닉네임입니다."
                self.isValidNickName = true
                self.setStartBtnStatus()
            case .requestErr(let res):
                self.activityIndicator.stopAnimating()
                if let message = res as? String {
                    self.nickNameInfoLabel.textColor = .errorTextRed
                    self.nickNameInfoLabel.text = message
                }
            default:
                self.activityIndicator.stopAnimating()
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
    
    /// 회원가입 요청 메서드
    private func requestSignUp(email: String, pw: String, nickname: String, orientation: String) {
        self.activityIndicator.startAnimating()
        SignAPI.shared.requestSignUpAPI(email: email, pw: pw, nickname: nickname, orientation: orientation) { networkResult in
            switch networkResult {
            case .success:
                self.activityIndicator.stopAnimating()
                guard let signInVC = UIStoryboard.init(name: Identifiers.SignInSB, bundle: nil).instantiateViewController(withIdentifier: SignInVC.className) as? SignInVC else { return }
                
                signInVC.modalPresentationStyle = .fullScreen
                self.present(signInVC, animated: true, completion: nil)
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
