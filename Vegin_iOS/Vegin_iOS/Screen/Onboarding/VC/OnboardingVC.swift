//
//  OnboardingVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/04/26.
//

import UIKit

class OnboardingVC: BaseVC {
    @IBOutlet weak var OnboardingCV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startBtn: VeginBtn! { didSet { startBtn.isActivated = false  } }
    @IBOutlet weak var skipBtn: UIButton!
    
    // MARK: - Properties
    var onboardingData: [OnboardingData] = []
    var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == onboardingData.count - 1 {
                startBtn.setTitle("시작하기", for: .normal)
                startBtn.isActivated = true
            } else {
                startBtn.setTitle("다음", for: .normal)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCV()
        registerCVC()
        initData()
        /// 첫 실행 확인 함수
        isitFirst()
        
        
        /// PageControl 설정
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.main
        pageControl.currentPageIndicatorTintColor = UIColor.darkMain
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        if currentPage == onboardingData.count - 1 {
            print("go to main")
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            OnboardingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func tapStartBtn(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(identifier: "SignUpVC")
        nextVC?.modalTransitionStyle = .coverVertical
        nextVC?.modalPresentationStyle = .automatic
        self.present(nextVC!, animated: true, completion: nil)
    }
    
    @IBAction func tapSkipBtn(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(identifier: "SignUpVC")
        nextVC?.modalTransitionStyle = .coverVertical
        nextVC?.modalPresentationStyle = .automatic
        self.present(nextVC!, animated: true, completion: nil)
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
            OnboardingData(onboardingImgName: "Onboarding1", boldText: "지구와 나를 위한 기분 좋은 변화!", contentText: "오늘 나의 고기 반찬이 아마존 산림을 파괴할 수도 있다고? 환경도 보호하고 식이조절로 건강도 챙기려고 했지만 어째 늘 막막했던 비건 식단, 이제는 손쉽게 비긴에서 유지해요"),
            OnboardingData(onboardingImgName: "Onboarding2", boldText: "언제나!", contentText: "클릭 한 번으로 입력되는 나의 식단! 한 달 내내 먹은 걸로 나에게 맞는 비건 지향성을 파악해요 클릭하는 버튼만 바뀌어도 내 식단을 항상 기억해 줘요"),
            OnboardingData(onboardingImgName: "Onboarding3", boldText: "어디에서나!", contentText: "어려웠던 비건 식단을 나만의 채식 메이트가 관리해 주니까 오늘은 이 캐릭터를 가지고 싶어! 야채를 조금만 더 먹어 볼까? 맛있는 식사를 하니 귀여운 메이트가 바로 내 옆에"),
            OnboardingData(onboardingImgName: "Onboarding4", boldText: "지속할 수 있으니까!", contentText: "나만 하는 게 아닌, 우리가 함께하니까! 피드를 통해 비건의 꿀팁을 찾아보고 생활을 공유해요 하나씩 쌓다 보면 오늘부터 나도 프로 비긴러")
        ])
    }
    
    private func setStartBtn() {
        /// 마지막 화면에서 버튼 활성화
        if pageControl.numberOfPages == 4 {
            self.startBtn.isActivated = true
        } else {
            self.startBtn.isActivated = false
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingVC: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
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
        /// 스크롤로 방향을 체크하여 올림, 내림을 사용하면 더 자연스럽게 페이징 가능
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

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCVC.className, for: indexPath) as? OnboardingCVC else {
            return UICollectionViewCell()
        }
        cell.setData(OnboardingData: onboardingData[indexPath.row])
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
