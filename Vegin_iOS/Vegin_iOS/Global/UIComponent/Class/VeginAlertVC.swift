//
//  VeginAlertVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/22.
//

import UIKit

class VeginAlertVC: BaseVC {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
       
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: IBAction
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI
extension VeginAlertVC {
    private func configureUI() {
        alertView.makeRounded(cornerRadius: 20.adjusted)
        confirmBtn.makeRounded(cornerRadius: 12.adjusted)
        messageLabel.setLineSpacing(lineSpacing: 5)
        messageLabel.textAlignment = .center
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
}

// MARK: - Custom Methods
extension VeginAlertVC {
    func showVeginAlert(vc: UIViewController, message: String, confirmBtnTitle: String) {
        messageLabel.text = message
        vc.present(self, animated: true, completion: nil)
    }
}
