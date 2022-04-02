//
//  SignInVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/26.
//

import UIKit

class SignInVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var loginBtn: VeginBtn!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var pwErrorLabel: UILabel!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpDelegate()
    }
    
    // MARK: IBAction
    @IBAction func tapSignInBtn(_ sender: Any) {
        requestSignIn()
    }
    @IBAction func tapSignUpBtn(_ sender: UIButton) {
        guard let signUpVC = UIStoryboard.init(name: Identifiers.SignUpSB, bundle: nil).instantiateViewController(withIdentifier: SignUpNVC.className) as? SignUpNVC else { return }

        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }
}

// MARK: - UI
extension SignInVC {
    private func configureUI() {
        loginBtn.setTitleWithStyle(title: "LOGIN", size: 16, weight: .bold)
        loginBtn.isActivated = false
        
        emailErrorLabel.text = ""
        pwErrorLabel.text = ""
        emailTextField.font = .PretendardSB(size: 14)
        pwTextField.font = .PretendardSB(size: 14)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요.", attributes: [NSAttributedString.Key.font: UIFont.PretendardR(size: 14)!])
        pwTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요.", attributes: [NSAttributedString.Key.font: UIFont.PretendardR(size: 14)!])
    }
}

// MARK: - Custom Methods
extension SignInVC {
    private func setUpDelegate() {
        emailTextField.delegate = self
        pwTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func checkEmailPwIsValid() {
        let emailText = emailTextField.text
        
        if (emailText?.contains("@"))! && (emailText?.contains("."))! && !(self.pwTextField.text?.isEmpty ?? false) {
            loginBtn.isActivated = true
        } else {
            loginBtn.isActivated = false
        }
    }
    
    /// UserDefault에 값 세팅하는 함수
    private func setUpUserdefaultValuesForSignIn(data: SignInDataModel) {
        UserDefaults.standard.set(emailTextField.text, forKey: UserDefaults.Keys.Email)
        UserDefaults.standard.set(pwTextField.text, forKey: UserDefaults.Keys.PW)
        UserDefaults.standard.set(data.user.userID, forKey: UserDefaults.Keys.UserID)
        UserDefaults.standard.set(data.accesstoken, forKey: UserDefaults.Keys.AccessToken)
        UserDefaults.standard.set(data.user.character, forKey: UserDefaults.Keys.CharacterID)
    }
    
    private func doForIsEmailVerified(data: SignInDataModel) {
        
        /// 메인 화면으로 전환
        guard let veginTBC = UIStoryboard.init(name: Identifiers.Main, bundle: nil).instantiateViewController(withIdentifier: VeginTBC.className) as? VeginTBC else { return }
        
        veginTBC.modalPresentationStyle = .fullScreen
        self.present(veginTBC, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            textField.resignFirstResponder()
            self.pwTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    @objc
    func textFieldDidChange(_ sender: Any?) {
        emailErrorLabel.text = ""
        pwErrorLabel.text = ""
        checkEmailPwIsValid()
    }
}

// MARK: - Network
extension SignInVC {
    
    /// 로그인 요청하는 메서드
    private func requestSignIn() {
        self.activityIndicator.startAnimating()
        SignAPI.shared.requestSignInAPI(email: emailTextField.text ?? "", pw: pwTextField.text ?? "") { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? SignInDataModel {
                    self.doForIsEmailVerified(data: data)
                }
            case .requestErr(let res):
                self.activityIndicator.stopAnimating()
                if let message = res as? String {
                    if message == "이메일 형식을 확인해주세요." {
                        self.emailErrorLabel.text = "존재하지 않는 회원입니다."
                    } else {
                        self.pwErrorLabel.text = "잘못된 비밀번호입니다."
                    }
                } else if res is Int {
                    self.emailErrorLabel.text = "존재하지 않는 회원입니다."
                }
            default:
                self.activityIndicator.stopAnimating()
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}
