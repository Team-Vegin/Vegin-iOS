//
//  SignInVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/26.
//

import UIKit

class SignInVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var loginBtn: VeginBtn! {
        didSet {
            loginBtn.setTitleWithStyle(title: "LOGIN", size: 16, weight: .bold)
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
