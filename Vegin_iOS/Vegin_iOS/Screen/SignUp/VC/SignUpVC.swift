//
//  SignUpVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/28.
//

import UIKit

class SignUpVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var emailCheckBtn: VeginBtn! {
        didSet {
            emailCheckBtn.isActivated = false
            emailCheckBtn.setTitleWithStyle(title: "중복확인", size: 12, weight: .bold)
            emailCheckBtn.press {
                self.emailInfoLabel.text = "사용 가능한 이메일입니다."
            }
        }
    }
    @IBOutlet weak var signUpBtn: VeginBtn! {
        didSet {
            signUpBtn.isActivated = false
            signUpBtn.setTitleWithStyle(title: "SIGN UP", size: 16, weight: .bold)
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailInfoLabel: UILabel!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwInfoLabel: UILabel!
    @IBOutlet weak var pwCheckTextField: UITextField!
    @IBOutlet weak var pwCheckInfoLabel: UILabel!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpDelegate()
    }
    
    // MARK: IBAction
    @IBAction func tapSignUpBtn(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: NickNameVC.className) as? NickNameVC else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - Custom Method
extension SignUpVC {
    private func configureUI() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요.", attributes: [NSAttributedString.Key.font: UIFont.PretendardR(size: 14)!])
        pwTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해 주세요. (최소 10자)", attributes: [NSAttributedString.Key.font: UIFont.PretendardR(size: 14)!])
        pwCheckTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 다시 입력해주세요.", attributes: [NSAttributedString.Key.font: UIFont.PretendardR(size: 14)!])
        
        emailInfoLabel.text = ""
        pwInfoLabel.text = ""
        pwCheckInfoLabel.text = ""
    }
}

// MARK: - Custom Method
extension SignUpVC {
    private func setUpDelegate() {
        emailTextField.delegate = self
        pwTextField.delegate = self
        pwCheckTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        pwCheckTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    /// 중복확인 버튼, signUp버튼 활성화 여부 판단 함수
    private func setBtnStatus() {
        if !emailTextField.isEmpty {
            emailCheckBtn.isActivated = true
        } else {
            emailCheckBtn.isActivated = false
            emailInfoLabel.text = ""
        }
        
        if !emailTextField.isEmpty && pwTextField.text?.count ?? 0 >= 10 && !pwCheckTextField.isEmpty {
            if pwTextField.text == pwCheckTextField.text {
                signUpBtn.isActivated = true
            } else {
                signUpBtn.isActivated = false
            }
        }
    }
    
    /// 비밀번호 유효성 검사 함수
    private func checkPwIsValid() {
        if !pwTextField.isEmpty {
            if pwTextField.text?.count ?? 0 >= 10 {
                pwInfoLabel.text = ""
            } else {
                pwInfoLabel.text = "최소 10자 이상 입력해주세요."
            }
        }
        
        if !pwCheckTextField.isEmpty {
            if pwTextField.text == pwCheckTextField.text {
                pwCheckInfoLabel.text = ""
            } else {
                pwCheckInfoLabel.text = "비밀번호가 다릅니다."
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            textField.resignFirstResponder()
            self.pwTextField.becomeFirstResponder()
        } else if textField == self.pwTextField {
            textField.resignFirstResponder()
            self.pwCheckTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    @objc
    func textFieldDidChange(_ sender: Any?) {
        setBtnStatus()
        checkPwIsValid()
    }
}
