//
//  NickNameVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/28.
//

import UIKit

class NickNameVC: UIViewController {

    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var flexiterianBtn: UIButton!
    @IBOutlet weak var polloBtn: UIButton!
    @IBOutlet weak var pescoBtn: UIButton!
    @IBOutlet weak var lactoOvoBtn: UIButton!
    @IBOutlet weak var lactoBtn: UIButton!
    @IBOutlet weak var veganBtn: UIButton!
    @IBOutlet weak var notYetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension NickNameVC {
    private func configureUI() {
        nickNameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해 주세요. (최대 12자)", attributes: [NSAttributedString.Key.font: UIFont.PretendardR(size: 14)!])
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach { btn in btn?.backgroundColor = .white
            btn?.makeRounded(cornerRadius: 0.5 * (btn?.bounds.size.height)!)
            btn?.layer.borderColor = UIColor.gray0.cgColor
            btn?.layer.borderWidth = 1
        }
    }
}
