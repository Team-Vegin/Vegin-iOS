//
//  CharacterBookVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/03/24.
//

import UIKit

///UICharacterControllView
class CharacterBookVC: UIViewController {
    // MARK: IBOutlet
    @IBOutlet weak var characterCV: UICollectionView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView.delegate = self
        //collectionView.dataSource = self
        configureUI()
    }
    
    // MARK: IBAction
    @IBAction func tapNaviBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Proporties
    private lazy var carouselCV : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        ///수평으로 스크롤
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CharacterBookCVC")
        return collectionView
    }()
    
    // MARK: UICollectionViewCell
    ///cell을 xib로
    private let cellData : [UICollectionViewCell] = []
    
    private lazy var increasedCellData :  [UICollectionViewCell] = {
        cellData + cellData + cellData
    }()
    
    private var originalCellDataCount : Int {
        cellData.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        carouselCV.horizontalScrollIndicatorInsets
        //carouselCV.scrollToItem(at: IndexPath(item: originalCellDataCount, section: 11), at: .centeredHorizontally, animated: false)
    }
    
    // MARK: ConfigureUI
    private func configureUI() {
        view.addSubview(carouselCV)
        
        carouselCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carouselCV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carouselCV.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            carouselCV.widthAnchor.constraint(equalTo: view.widthAnchor),
            carouselCV.heightAnchor.constraint(equalToConstant: 616)
        ])
    }
}

//MARK: UICollectionViewDelegate
extension CharacterBookVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForRowAt indexpath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

//MARK:  UICollectionViewDelegateFlowLayout
extension CharacterBookVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 616)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

//MARK: UICollectionViewDataSource
extension CharacterBookVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return increasedCellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterBookCVC", for: indexPath)
        return cell
    }
}
