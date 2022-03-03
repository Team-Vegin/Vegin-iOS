//
//  VeginAlertVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/22.
//

import UIKit

class VeginAlertVC: BaseVC {

    // MARK: Properties
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
       
    // MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureUI() {
        alertView.makeRounded(cornerRadius: 20.adjusted)
        confirmBtn.makeRounded(cornerRadius: 0.5 * confirmBtn.bounds.size.height)
        messageLabel.setLineSpacing(lineSpacing: 5)
        messageLabel.textAlignment = .center
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    func showVeginAlert(vc: UIViewController, message: String, confirmBtnTitle: String) {
        messageLabel.text = message
        vc.present(self, animated: true, completion: nil)
    }
    
    // MARK: IBAction
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
