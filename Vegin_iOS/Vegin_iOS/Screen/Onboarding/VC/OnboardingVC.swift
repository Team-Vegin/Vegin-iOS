//
//  OnboardingVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/04/26.
//

import UIKit

class OnboardingVC: UIViewController {
    @IBOutlet weak var OnboardingCV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    
    // MARK: - Properties
    var onboardingData: [OnboardingData] = []
    var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == onboardingData.count - 1 {
                startBtn.setTitle("다음", for: .normal)
            } else {
                startBtn.setTitle("시작하기", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 첫 실행 확인 함수
        isitFirst()
        
        /// PageControl 설정
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.main
        pageControl.currentPageIndicatorTintColor = UIColor.darkMain
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
    }
}

// MARK: - Custom Methods
extension OnboardingVC {
    private func setUpCV() {
        OnboardingCV.delegate = self
        OnboardingCV.dataSource = self
        OnboardingCV.isPagingEnabled = true
    }
    
    // 첫 실행 확인
    private func isitFirst() {
        
    }
    
    private func registerCVC() {
        OnboardingCVC.register(target: OnboardingCV)
    }
    
    private func initData() {
        onboardingData.append(contentsOf: [
            OnboardingData(onboardingImgName: "Onboarding1", boldText: "제목입니다", contentText: "String"),
            OnboardingData(onboardingImgName: "Onboarding2", boldText: "제목입니다", contentText: "String"),
            OnboardingData(onboardingImgName: "Onboarding3", boldText: "제목입니다", contentText: "String"),
            OnboardingData(onboardingImgName: "Onboarding4", boldText: "제목입니다", contentText: "String")
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingVC: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
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
        let layout = self.OnboardingCV.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        /// targetContentOffset을 이용하여 x좌표가 얼마나 이동했는지 확인
        /// 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
        var offset = targetContentOffset.pointee
        /// 멈추는 위치 설정
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        var currentIndex: CGFloat = 0   // 현재 페이지의 인덱스
        
        ///페이지 컨트롤 연결
        self.pageControl.currentPage = Int(currentIndex)
        
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
extension OnboardingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCVC.className, for: indexPath) as? OnboardingCVC else {
            return UICollectionViewCell()
        }
        cell.setData(OnboardingData: onboardingData[indexPath.row])
        return cell
    }
}
