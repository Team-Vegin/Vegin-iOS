//
//  CharacterBookVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/03/16.
//

import UIKit


class CharacterBookVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapNaviBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
