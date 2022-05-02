//
//  FeedMainEmptyTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/25.
//

import UIKit

class FeedMainEmptyTVC: BaseTVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var categoryCV: UICollectionView!
    
    // MARK: Properties
    var categoryList = [String]()
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCV()
        registerCVC()
        initDataList()
        setUpDefaultSelectedCategory()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Custom Methods
    private func setUpCV() {
        categoryCV.dataSource = self
        categoryCV.delegate = self
    }
    
    private func registerCVC() {
        CategoryCVC.register(target: categoryCV)
    }
    
    private func initDataList() {
        categoryList.append(contentsOf: [
            "전체", "생활", "맛집", "꿀팁", "레시피", "기타"
        ])
    }
    
    /// 디폴트로 선택된 카테고리 설정 함수
    private func setUpDefaultSelectedCategory() {
        self.categoryCV.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedMainEmptyTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: categoryList[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 31, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 21, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - UICollectionViewDataSource
extension FeedMainEmptyTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
        
        cell.setCategoryData(categoryData: categoryList[indexPath.row])
        return cell
    }
}
