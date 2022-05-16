//
//  FeedDetailEmojiTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/04/13.
//

import UIKit

class FeedDetailEmojiTVC: BaseTVC {

    // MARK: Properties
    var tapPlusBtnAction: (() -> ())?
    var emojiData: [EmojiList] = []
    
    // MARK: IBOutlet
    @IBOutlet weak var emojiCV: UICollectionView!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCVC()
        setUpCV()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func tapPlusBtn(_ sender: UIButton) {
        tapPlusBtnAction?()
    }
    
}

// MARK: - Custom Methods
extension FeedDetailEmojiTVC {
    private func registerCVC() {
        EmojiCountCVC.register(target: emojiCV)
    }
    
    private func setUpCV() {
        emojiCV.delegate = self
        emojiCV.dataSource = self
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedDetailEmojiTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 58.adjusted
        let cellHeight = 30.adjustedH
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

// MARK: - UICollectionViewDataSource
extension FeedDetailEmojiTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCountCVC.className, for: indexPath) as? EmojiCountCVC else { return UICollectionViewCell() }
        
        cell.setData(data: emojiData[indexPath.row])
        return cell
    }
}
