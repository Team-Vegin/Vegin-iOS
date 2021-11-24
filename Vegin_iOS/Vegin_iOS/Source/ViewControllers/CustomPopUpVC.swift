//
//  CustomPopUpVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/22.
//

import UIKit

class CustomPopUpVC: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var farmCheckButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.addTarget(self, action: #selector(okButtonClicked(_sender:)), for: .touchUpInside)
        farmCheckButton.addTarget(self, action: #selector(farmCheckButtonClicked(_sender:)), for: .touchUpInside)
        setUI()

    }
    
    private func setUI() {
        alertView.layer.cornerRadius = 20
    }
    
    @objc func okButtonClicked(_sender: UIButton) {
        //dismiss(animated: true, completion: nil)
        let tabBarStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let nextVC = tabBarStoryBoard.instantiateViewController(withIdentifier: TabBarController.className) as? TabBarController else { return }
        
        nextVC.selectedIndex = 0
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        present(nextVC, animated: true, completion: nil)
    }
    
    @objc func farmCheckButtonClicked(_sender: UIButton) {
        //dismiss(animated: true, completion: nil)
        let tabBarStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let nextVC = tabBarStoryBoard.instantiateViewController(withIdentifier: TabBarController.className) as? TabBarController else { return }
        
        nextVC.selectedIndex = 1
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        present(nextVC, animated: true, completion: nil)
    }
}
