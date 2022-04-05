//
//  FeedWriteVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/04/02.
//

import UIKit

class FeedWriteVC: BaseVC {
    //MARK: IBOutlet
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var feedImgView: UIImageView!
    @IBOutlet weak var imgContectView: UIView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var categoryBtn1: UIButton!
    @IBOutlet weak var categoryBtn2: UIButton!
    @IBOutlet weak var categoryBtn3: UIButton!
    @IBOutlet weak var categoryBtn4: UIButton!
    @IBOutlet weak var categoryBtn5: UIButton!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var saveBtn: VeginBtn! {
        didSet {
            saveBtn.isActivated = false
            saveBtn.setTitleWithStyle(title: "저장하기", size: 16, weight: .semiBold)
        }
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: IBAction
    @IBAction func tapNaviBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
