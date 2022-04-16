//
//  VeginAlertVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/22.
//

import UIKit
import SnapKit
import Then

enum VeginAlertType {
    
    /// confirmBtn만 사용
    case withSingleBtn
    
    /// confirmBtn, cancelBtn 사용
    case withDoubleBtn
    
}

class VeginAlertVC: BaseVC {

    // MARK: Properties
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var confirmBtn: VeginBtn!
    @IBOutlet weak var cancelBtn: VeginBtn! {
        didSet {
            self.cancelBtn.setBtnColors(normalBgColor: .main, normalFontColor: .darkMain, activatedBgColor: .main, activatedFontColor: .darkMain)
        }
    }
    
    
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
        confirmBtn.isActivated = true
        cancelBtn.isActivated = true
        messageLabel.setLineSpacing(lineSpacing: 5)
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    func showVeginAlert(vc: UIViewController, message: String, confirmBtnTitle: String, cancelBtnTitle: String, iconImg: String, type: VeginAlertType? = .withDoubleBtn) {
        messageLabel.text = message
        iconImgView.image = UIImage(named: iconImg)
        
        switch type {
        case .withSingleBtn:
            DispatchQueue.main.async {
                self.view.addSubviews([self.messageLabel, self.confirmBtn])
                self.cancelBtn.removeFromSuperview()
                self.confirmBtn.setTitleWithStyle(title: confirmBtnTitle, size: 12, weight: .bold)
                self.messageLabel.snp.makeConstraints {
                    $0.top.equalTo(self.iconImgView.snp.bottom).offset(4)
                    $0.centerX.equalTo(self.alertView.snp.centerX)
                }
                self.confirmBtn.snp.makeConstraints {
                    $0.centerX.equalTo(self.messageLabel.snp.centerX)
                    $0.top.equalTo(self.messageLabel.snp.bottom).offset(18)
                    $0.bottom.equalTo(self.alertView.snp.bottom).offset(-22)
                    $0.width.equalTo(70)
                    $0.height.equalTo(28)
                }
            }
        default:
            DispatchQueue.main.async {
                self.confirmBtn.setTitleWithStyle(title: confirmBtnTitle, size: 12, weight: .bold)
                self.cancelBtn.setTitleWithStyle(title: cancelBtnTitle, size: 12, weight: .bold)
            }
        }
        vc.present(self, animated: true, completion: nil)
    }
    
    // MARK: IBAction
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
