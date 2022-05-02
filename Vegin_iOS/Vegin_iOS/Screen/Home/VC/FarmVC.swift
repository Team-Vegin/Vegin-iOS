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
    @IBOutlet weak var mainCharacterBtn: UIButton!
    @IBOutlet weak var tapProgressBarBtn: UIButton!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
 
    @IBAction func tapCharaterBtn(_ sender: Any) {  //메인 캐릭터를 누르면 새로운 메세지로 변경 (서버 연결 전)
    }
    @IBAction func tapProgressBarBtn(_ sender: Any) {   //progressBar 누르면 진행중인 미션 노출 (서버 연결 전)
    }
}
