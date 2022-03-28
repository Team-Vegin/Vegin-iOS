//
//  SignUpVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/28.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var signUpBtn: VeginBtn! {
        didSet {
            signUpBtn.isActivated = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapSignUpBtn(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: NickNameVC.className) as? NickNameVC else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
