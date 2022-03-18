//
//  FarmVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/24.
//  Edited by TAEEUN on 2022/03/15.
//

import UIKit


class FarmVC: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var characterBookBtn: UIButton!
    @IBOutlet weak var mainCharacterBtn: UIButton!
    @IBOutlet weak var tapProgressBarBtn: UIButton!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBAction
    @IBAction func tapCharacterPageBtn(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: CharacterBookVC.className) as? CharacterBookVC else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func tapCharaterBtn(_ sender: Any) {  //메인 캐릭터를 누르면 새로운 메세지로 변경
    }
    @IBAction func tapProgressBarBtn(_ sender: Any) {   //progressBar 누르면 진행중인 미션 노출
    }
}
