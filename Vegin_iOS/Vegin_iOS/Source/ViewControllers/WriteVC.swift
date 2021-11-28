//
//  WriteVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/16.
//

import UIKit

class WriteVC: UIViewController {

    var isLevel1Selected = false {
        didSet {
            setIconImage()
        }
    }
    var isLevel2Selected = false {
        didSet {
            setIconImage()
        }
    }
    var isLevel3Selected = false {
        didSet {
            setIconImage()
        }
    }
    var isLevel4Selected = false {
        didSet {
            setIconImage()
        }
    }
    var isLevel5Selected = false {
        didSet {
            setIconImage()
        }
    }
    var isLevel6Selected = false {
        didSet {
            setIconImage()
        }
    }
    
    var indexOfMeal: Int?
    
    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var buttonContentView: UIView!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var level1Button: UIButton!
    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var level3Button: UIButton!
    @IBOutlet weak var level4Button: UIButton!
    @IBOutlet weak var level5Button: UIButton!
    @IBOutlet weak var level6Button: UIButton!
    
    @IBOutlet var mealButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        hideKeyboardWhenTappedAround()
        initUI()
    }
    
    @IBAction func touchUpToGoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpToSaveButton(_ sender: Any) {
        let vc = CustomPopUpVC(nibName: CustomPopUpVC.className, bundle: nil)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    func setIconImage() {
        if isLevel1Selected {
            level1Button.setImage(UIImage.init(named: "level1_select"), for: .normal)
        } else if !isLevel1Selected {
            level1Button.setImage(UIImage.init(named: "brocoli"), for: .normal)
        }
        
        if isLevel2Selected {
            level2Button.setImage(UIImage.init(named: "level2_select"), for: .normal)
        } else if !isLevel2Selected {
            level2Button.setImage(UIImage.init(named: "milk"), for: .normal)
        }
        
        if isLevel3Selected {
            level3Button.setImage(UIImage.init(named: "level3_select"), for: .normal)
        } else if !isLevel3Selected {
            level3Button.setImage(UIImage.init(named: "egg"), for: .normal)
        }
        
        if isLevel4Selected {
            level4Button.setImage(UIImage.init(named: "level4_select"), for: .normal)
        } else if !isLevel4Selected {
            level4Button.setImage(UIImage.init(named: "fish"), for: .normal)
        }
        
        if isLevel5Selected {
            level5Button.setImage(UIImage.init(named: "level5_select"), for: .normal)
        } else if !isLevel5Selected {
            level5Button.setImage(UIImage.init(named: "chicken"), for: .normal)
        }
        
        if isLevel6Selected {
            level6Button.setImage(UIImage.init(named: "level6_select"), for: .normal)
        } else if !isLevel6Selected {
            level6Button.setImage(UIImage.init(named: "meat"), for: .normal)
        }

    }
    
    @IBAction func touchUpLevel1Btn(_ sender: Any) {
        isLevel1Selected = !isLevel1Selected
    }
    @IBAction func touchUpLevel2Btn(_ sender: Any) {
        isLevel2Selected = !isLevel2Selected
    }
    
    @IBAction func touchUpLevel3Btn(_ sender: Any) {
        isLevel3Selected = !isLevel3Selected
    }
    @IBAction func touchUpLevel4Btn(_ sender: Any) {
        isLevel4Selected = !isLevel4Selected
    }
    @IBAction func touchUpLevel5Btn(_ sender: Any) {
        isLevel5Selected = !isLevel5Selected
    }
    @IBAction func touchUpLevel6Btn(_ sender: Any) {
        isLevel6Selected = !isLevel6Selected
    }
    
    @IBAction func touchUpMealButton(_ sender: UIButton) {
        if indexOfMeal != nil {
            if !sender.isSelected {
                for index in mealButtons.indices {
                    mealButtons[index].isSelected = false
                }
                sender.isSelected = true
                indexOfMeal = mealButtons.firstIndex(of: sender)
            } else {
                sender.isSelected = false
                indexOfMeal = nil
            }
        } else {
            sender.isSelected = true
            indexOfMeal = mealButtons.firstIndex(of: sender)
        }
    }
    
    private func setUI() {
        imageContentView.layer.cornerRadius = 25
        buttonContentView.layer.cornerRadius = 20
        mealButtons[0].setImage(UIImage.init(named: "select"), for: .selected)
        mealButtons[0].setImage(UIImage.init(named: "breakfast"), for: .normal)
        mealButtons[0].tintColor = .white
        mealButtons[1].setImage(UIImage.init(named: "select-4"), for: .selected)
        mealButtons[1].setImage(UIImage.init(named: "brunch"), for: .normal)
        mealButtons[1].tintColor = .white
        mealButtons[2].setImage(UIImage.init(named: "select-2"), for: .selected)
        mealButtons[2].setImage(UIImage.init(named: "lunch"), for: .normal)
        mealButtons[2].tintColor = .white
        mealButtons[3].setImage(UIImage.init(named: "select-3"), for: .selected)
        mealButtons[3].setImage(UIImage.init(named: "lundinner"), for: .normal)
        mealButtons[3].tintColor = .white
        mealButtons[4].setImage(UIImage.init(named: "select-1"), for: .selected)
        mealButtons[4].setImage(UIImage.init(named: "dinner"), for: .normal)
        mealButtons[4].tintColor = .white
    }
}

extension WriteVC: UITextViewDelegate {
    @objc
    func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
        }
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}

extension WriteVC {
    func initUI() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        memoTextView.delegate = self
    }
}

