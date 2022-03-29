//
//  NickNameVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/28.
//

import UIKit

class NickNameVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var flexiterianBtn: UIButton!
    @IBOutlet weak var polloBtn: UIButton!
    @IBOutlet weak var pescoBtn: UIButton!
    @IBOutlet weak var lactoOvoBtn: UIButton!
    @IBOutlet weak var lactoBtn: UIButton!
    @IBOutlet weak var veganBtn: UIButton!
    @IBOutlet weak var notYetBtn: UIButton!
    @IBOutlet weak var startBtn: VeginBtn! {
        didSet {
            startBtn.isActivated = true
            startBtn.setTitleWithStyle(title: "Vegin 시작하기!", size: 16, weight: .bold)
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: IBAction
    @IBAction func tapFlexiterianBtn(_ sender: UIButton) {
        flexiterianBtn.isSelected.toggle()
        [polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
    }
    
    @IBAction func tapPolloBtn(_ sender: UIButton) {
        polloBtn.isSelected.toggle()
        [flexiterianBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
    }
    
    @IBAction func tapPescoBtn(_ sender: UIButton) {
        pescoBtn.isSelected.toggle()
        [flexiterianBtn, polloBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
    }
    
    @IBAction func tapLactoOvoBtn(_ sender: UIButton) {
        lactoOvoBtn.isSelected.toggle()
        [flexiterianBtn, polloBtn, pescoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
    }
    
    @IBAction func tapLactoBtn(_ sender: UIButton) {
        lactoBtn.isSelected.toggle()
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, veganBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
    }
    
    @IBAction func tapVeganBtn(_ sender: UIButton) {
        veganBtn.isSelected.toggle()
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, notYetBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
    }
    
    @IBAction func tapNotYetBtn(_ sender: UIButton) {
        notYetBtn.isSelected.toggle()
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn].forEach {
            btn in btn?.isSelected = false
        }
        [flexiterianBtn, polloBtn, pescoBtn, lactoOvoBtn, lactoBtn, veganBtn, notYetBtn].forEach {
            btn in setBtnStatus(btn: btn)
        }
    }
    
}

// MARK: - UI
extension NickNameVC {
    private func configureUI() {
        nickNameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해 주세요. (최대 12자)", attributes: [NSAttributedString.Key.font: UIFont.PretendardR(size: 14)!])
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
    
    /// 버튼 상태에 따른 UI 설정 함수
    private func setBtnStatus(btn: UIButton) {
        if btn.isSelected {
            configureBtnUI(btn: btn, btnBgColor: .darkMain, btnTitleColor: .white, btnBorderColor: UIColor.darkMain.cgColor)
        } else {
            configureBtnUI(btn: btn, btnBgColor: .white, btnTitleColor: .gray0, btnBorderColor: UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 0.5).cgColor)
        }
    }
}
