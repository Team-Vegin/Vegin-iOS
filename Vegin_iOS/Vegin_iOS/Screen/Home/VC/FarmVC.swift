//
//  FarmVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/24.
//

import UIKit


class FarmVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var characterBookBtn: UIButton!
    @IBOutlet weak var missionInfoView: UIView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabbar()
    }
    
    // MARK: IBAction
    @IBAction func tapCahracterPageBtn(_ sender: UIButton) {
        guard let CharacterBookVC = UIStoryboard.init(name: "HomeSB", bundle: nil).instantiateViewController(withIdentifier: CharacterBookVC.className) as? CharacterBookVC else { return }
        
        self.navigationController?.pushViewController(CharacterBookVC, animated: true)
    }
}

extension FarmVC {
    private func configureUI() {
        messageLabel.setLineSpacing(lineSpacing: 2)
        missionInfoView.makeRounded(cornerRadius: 0.5 * missionInfoView.bounds.height)
    }
}
