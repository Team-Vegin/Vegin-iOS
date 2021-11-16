//
//  WriteVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/16.
//

import UIKit

class WriteVC: UIViewController {

    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var buttonContentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func touchUpToGoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        imageContentView.layer.cornerRadius = 25
        buttonContentView.layer.cornerRadius = 20
    }

}
