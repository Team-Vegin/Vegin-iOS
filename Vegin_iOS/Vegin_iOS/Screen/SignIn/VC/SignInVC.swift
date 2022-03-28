//
//  SignInVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/26.
//

import UIKit

class SignInVC: UIViewController {

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
        checkEmailPwIsValid()
    }
}
