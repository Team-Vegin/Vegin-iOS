//
//  CharacterBookVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/03/28.
//

import UIKit

class CharacterBookVC: UIViewController {
    @IBOutlet weak var characterBookCV: UICollectionView!
    
    // MARK: Properties
    var charcterBookData: [CharacterBookData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCV()
        registerCVC()
        initData()
    }
}

// MARK: - Custom Methods
extension CharacterBookVC {
    private func setUpCV() {
        characterBookCV.delegate = self
        characterBookCV.dataSource = self
        characterBookCV.isPagingEnabled = true
        characterBookCV.backgroundColor = .clear
    }
    
    private func registerCVC() {
        CharacterBookCVC.register(target: characterBookCV)
    }
    
    private func initData() {
        charcterBookData.append(contentsOf: [
            CharacterBookData(characterImgName: "Tomavi_1", characterName: "토마비", firstMission: "처음 기록하기", secondMission: "두번쨰 기록하기", thirdMission: "세번째 기록하기"),
            CharacterBookData(characterImgName: "Hidden_Dangvi", characterName: "당비", firstMission: "처음 기록하기", secondMission: "두번쨰 기록하기", thirdMission: "세번째 기록하기"),
            CharacterBookData(characterImgName: "Hidden_Onion", characterName: "양비", firstMission: "처음 기록하기", secondMission: "두번쨰 기록하기", thirdMission: "세번째 기록하기"),
            CharacterBookData(characterImgName: "Hidden_Pavi", characterName: "파비", firstMission: "처음 기록하기", secondMission: "두번쨰 기록하기", thirdMission: "세번째 기록하기"),
            CharacterBookData(characterImgName: "Hidden_Cabbage", characterName: "양배비", firstMission: "처음 기록하기", secondMission: "두번쨰 기록하기", thirdMission: "세번째 기록하기"),
            CharacterBookData(characterImgName: "Hidden_Suvi", characterName: "수비", firstMission: "처음 기록하기", secondMission: "두번쨰 기록하기", thirdMission: "세번째 기록하기"),
            CharacterBookData(characterImgName: "Hidden_Oksuvi", characterName: "옥수비", firstMission: "처음 기록하기", secondMission: "두번쨰 기록하기", thirdMission: "세번째 기록하기"),
            CharacterBookData(characterImgName: "Hidden_Bluevi", characterName: "블루비", firstMission: "처음 기록하기", secondMission: "두번쨰 기록하기", thirdMission: "세번째 기록하기"),
            CharacterBookData(characterImgName: "Hidden_Ddalvi", characterName: "딸비", firstMission: "처음 기록하기", secondMission: "두번쨰 기록하기", thirdMission: "세번째 기록하기"),
            CharacterBookData(characterImgName: "Hidden_Hovi", characterName: "호비", firstMission: "처음 기록하기", secondMission: "두번쨰 기록하기", thirdMission: "세번째 기록하기"),
            
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharacterBookVC: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// width, heigt 설정
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    /// 상하, 좌우 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        /// item 사이즈와 item 간격 사이즈를 구해 하나의 item 크기로 설정
        let layout = self.characterBookCV.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        /// targetContentOffset을 이용하여 x좌표가 얼마나 이동했는지 확인
        /// 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
        var offset = targetContentOffset.pointee
        /// 멈추는 위치 설정
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        var currentIndex: CGFloat = 0   // 현재 페이지의 인덱스
        
        /// scrollView,targetContentOffset 좌표 값으로 스크롤 방향 확인
        /// index를 반올림해서 사용하면 item의 절반 사이즈만큼 스크롤해야 페이징 됨
        ///  스크롤로 방향을 체크하여 올림, 내림을 사용하면 더 자연스럽게 페이징 가능
        if scrollView.contentOffset.x > targetContentOffset.pointee.x { roundedIndex = floor(index) }
        else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }
        
        if currentIndex > roundedIndex {
            currentIndex -= 1
            roundedIndex = currentIndex
        } else if currentIndex < roundedIndex {
            currentIndex += 1
            roundedIndex = index
        }
        
        /// 페이징 될 좌표값을 targetContentOffset에 대입
        offset = CGPoint(x: (roundedIndex * cellWidthIncludingSpacing) - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

// MARK: - UICollectionViewDataSource
extension CharacterBookVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterBookCVC.className, for: indexPath) as? CharacterBookCVC else {
            return UICollectionViewCell()
        }
        cell.setData(characterData: charcterBookData[indexPath.row])
        return cell
    }
}

