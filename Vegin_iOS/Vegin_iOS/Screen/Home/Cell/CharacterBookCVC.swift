//
//  CharacterBookCVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/03/24.
//

import UIKit

class CharacterBookCVC: UICollectionViewCell {
    // MARK: IBOutlet
    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var getMissionBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: UI
extension CharacterBookCVC {
    private func configureUI() {
        characterNameLabel.makeRounded(cornerRadius: 10.adjusted)
        missionLabel.makeRounded(cornerRadius: 5.adjusted)
        getMissionBtn.makeRounded(cornerRadius: 5.adjusted)
    }
}

// MARK: Custom Methods
extension CharacterBookCVC {
    func setData(postData: FeedMyPostListData) {
        characterImg.image = postData.makeThumbnailImg()
        characterNameLabel.text = postData.content
        missionLabel.text = postData.content
    }
}
