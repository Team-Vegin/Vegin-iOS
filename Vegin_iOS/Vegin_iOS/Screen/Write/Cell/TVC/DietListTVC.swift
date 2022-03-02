//
//  DietListTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/01.
//

import UIKit

class DietListTVC: BaseTVC {

    @IBOutlet weak var thumbnailImgView: UIImageView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureUI() {
        thumbnailImgView.makeRounded(cornerRadius: 10.adjusted)
        contentLabel.setLineSpacing(lineSpacing: 5)
    }
}

// MARK: - Custom Methods
extension DietListTVC {
    func setData(postData: DietPostData) {
        titleLabel.text = postData.title
        contentLabel.text = postData.content
        thumbnailImgView.image = postData.makeThumbnailImg()
        iconImgView.image = postData.makeIconImg()
    }
}
