//
//  EmojiAlertVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/06.
//

import UIKit

class EmojiAlertVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelBtn: VeginBtn! {
        didSet {
            cancelBtn.setTitleWithStyle(title: "취소", size: 12, weight: .bold)
            cancelBtn.isActivated = true
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        alertView.makeRounded(cornerRadius: 20.adjusted)
    }
    @IBAction func tapCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
