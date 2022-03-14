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

    func setData(iconData: IconImgData) {
        iconImgView.image = iconData.makeIconImg()
    }
}
