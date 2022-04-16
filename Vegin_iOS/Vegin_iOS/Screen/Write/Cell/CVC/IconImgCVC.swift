//
//  IconImgCVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/14.
//

import UIKit

class IconImgCVC: BaseCVC {

    @IBOutlet weak var iconImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(iconData: Int) {
        if iconData == 1 {
            iconImgView.image = UIImage(named: "level1")
        } else if iconData == 2 {
            iconImgView.image = UIImage(named: "level2")
        } else if iconData == 3 {
            iconImgView.image = UIImage(named: "level3")
        } else if iconData == 4 {
            iconImgView.image = UIImage(named: "level4")
        } else if iconData == 5 {
            iconImgView.image = UIImage(named: "level5")
        } else if iconData == 6 {
            iconImgView.image = UIImage(named: "level6")
        }
    }
}
