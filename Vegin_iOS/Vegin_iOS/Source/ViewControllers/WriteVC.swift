//
//  WriteVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/16.
//

import UIKit

class WriteVC: UIViewController {

    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var buttonContentView: UIView!
    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        hideKeyboardWhenTappedAround()
        initUI()
    }
    
    @IBAction func touchUpToGoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpToSaveButton(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        let vc = CustomPopUpVC(nibName: CustomPopUpVC.className, bundle: nil)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    private func setUI() {
        imageContentView.layer.cornerRadius = 25
        buttonContentView.layer.cornerRadius = 20
    }
}

extension WriteVC: UITextViewDelegate {
    @objc
    func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
        }
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}

extension WriteVC {
    func initUI() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        memoTextView.delegate = self
    }
}

