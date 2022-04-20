//
//  DietDetailIconTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/14.
//

import UIKit

class DietDetailIconTVC: BaseTVC {

    // MARK: IBOutlet
    @IBOutlet weak var iconCV: UICollectionView!
    
    // MARK: Properties
    var iconImgList: [Int] = []
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCV()
        setUpCV()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Custom Methods
extension DietDetailIconTVC {
    private func registerCV() {
        IconImgCVC.register(target: iconCV)
    }
    
    private func setUpCV() {
        iconCV.delegate = self
        iconCV.dataSource = self
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DietDetailIconTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 24, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

// MARK: - UICollectionViewDataSource
extension DietDetailIconTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconImgList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconImgCVC.className, for: indexPath) as? IconImgCVC else { return UICollectionViewCell() }
        cell.setData(iconData: iconImgList[indexPath.row])
        return cell
    }
}
