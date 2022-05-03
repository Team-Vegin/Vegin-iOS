//
//  CharacterBookVC.swift
//  Vegin_iOS
//
//  Created by Taeeun Lee on 2022/03/28.
//

import UIKit

class CharacterBookVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var characterBookCV: UICollectionView!
    
    // MARK: Properties
    var charcterBookData: [CharacterBookData] = []
    var selectedIndex: Int = -1
    var cellTagDelegate: SendDataDelegate?
    
    let cellSize = CGSize(width: UIScreen.main.bounds.width * (276/375), height: UIScreen.main.bounds.width * (276/375) * (616/276))
    var minItemSpacing: CGFloat = 20
    let cellCount = 10
    var previousIndex = 0
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideTabbar()
        setUpCV()
        registerCVC()
        initData()
    }
    
    // MARK: IBAction
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Custom Methods
extension CharacterBookVC {
    private func setUpCV() {
        characterBookCV.contentInsetAdjustmentBehavior = .never
        characterBookCV.contentInset = UIEdgeInsets(top: 0, left: CGFloat(54), bottom: 0, right: CGFloat(54))
        characterBookCV.decelerationRate = .fast
        characterBookCV.delegate = self
        characterBookCV.dataSource = self
        characterBookCV.backgroundColor = .clear
    }
    
    private func registerCVC() {
        CharacterBookCVC.register(target: characterBookCV)
    }

    private func initData() {
        charcterBookData.append(contentsOf: [
            CharacterBookData(characterImgName: "Tomavi_1", characterName: "토마비", firstMission: "비긴 설치하기", secondMission: "비긴 회원가입하기", thirdMission: "처음 접속하기", firstCheckImgName: "check_img", secondCheckImgName: "check_img", thirdCheckImgName: "check_img", characterExplanation: "성실한 토마토.\n 베푸는 것을 좋아하며 착하다."),
            CharacterBookData(characterImgName: "Hidden_Dangvi", characterName: "당비", firstMission: "식단 기록 1번 하기", secondMission: "레시피 피드 게시글에 느낌 1번 달기", thirdMission: "플렉시테리언 식단 2번 기록하기", firstCheckImgName: "lock", secondCheckImgName: "lock", thirdCheckImgName: "lock", characterExplanation: "귀찮은 당근.\n시크하게 열심히 충고해주는 편."),
            CharacterBookData(characterImgName: "Hidden_Onion", characterName: "양비", firstMission: "식단 기록 2일 하기", secondMission: "플렉시테리언 식단 기록 3번 하기", thirdMission: "생활 피드에 게시글 작성하기", firstCheckImgName: "lock", secondCheckImgName: "lock", thirdCheckImgName: "lock", characterExplanation: "소심한 양파.\n걱정이 많아서 꼼꼼하게 코칭해준다."),
            CharacterBookData(characterImgName: "Hidden_Pavi", characterName: "파비", firstMission: "피드에 글 1번 올리기", secondMission: "피드 게시글에 느낌 달기", thirdMission: "하루에 2번 식단 기록하기", firstCheckImgName: "lock", secondCheckImgName: "lock", thirdCheckImgName: "lock", characterExplanation: "엄격한 대파.\n본심은 따뜻한 노력’파’."),
            CharacterBookData(characterImgName: "Hidden_Cabbage", characterName: "양배비", firstMission: "피드에 글 2번 올리기", secondMission: "꿀팁 피드 게시글 작성하기", thirdMission: "당비 획득하기", firstCheckImgName: "lock", secondCheckImgName: "lock", thirdCheckImgName: "lock", characterExplanation: "상냥한 양배추.\n당비를 짝사랑하는 친절한 메이트."),
            CharacterBookData(characterImgName: "Hidden_Suvi", characterName: "수비", firstMission: "폴로-오보 식단 1번 기록하기", secondMission: "폴로 식단 1번 기록하기", thirdMission: "완전 비건 식단 1번 기록하기", firstCheckImgName: "lock", secondCheckImgName: "lock", thirdCheckImgName: "lock", characterExplanation: "까칠한 수박.\n틱틱거리지만 챙겨주는 것을 좋아한다."),
            CharacterBookData(characterImgName: "Hidden_Oksuvi", characterName: "옥수비", firstMission: "완전 채식 하루 해보기", secondMission: "하루 2번 식단 기록하기", thirdMission: "페스코 식단 2번 기록하기", firstCheckImgName: "lock", secondCheckImgName: "lock", thirdCheckImgName: "lock", characterExplanation: "느긋한 옥수수.\n뺀질거리지만 유머감각이 좋다."),
            CharacterBookData(characterImgName: "Hidden_Bluevi", characterName: "블루비", firstMission: "하루 3번 식단 기록하기", secondMission: "수비 획득하기", thirdMission: "맛집 피드 게시글 작성하기", firstCheckImgName: "lock", secondCheckImgName: "lock", thirdCheckImgName: "lock", characterExplanation: "영악한 블루베리.\n얄밉지만 미워할 수 없는 천재."),
            CharacterBookData(characterImgName: "Hidden_Ddalvi", characterName: "딸비", firstMission: "식단 기록 10번 이상하기", secondMission: "블루비 획득하기", thirdMission: "완전 채식 3일 이상 기록하기", firstCheckImgName: "lock", secondCheckImgName: "lock", thirdCheckImgName: "lock", characterExplanation: "무뚝뚝한 딸기.\n관심없어 보이지만 수줍어서 그런 것이다."),
            CharacterBookData(characterImgName: "Hidden_Hovi", characterName: "호비", firstMission: "다른 캐릭터 모두 획득하기", secondMission: "식단 기록 30번 이상하기", thirdMission: "피드 모든 카테고리 게시글 작성하기", firstCheckImgName: "lock", secondCheckImgName: "lock", thirdCheckImgName: "lock", characterExplanation: "호기심 많은 단호박.\n아직 애기라 발음이 잘 안된다.")  
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharacterBookVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}

// MARK: - UICollectionViewDelegate
extension CharacterBookVC: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludeSpacing = cellSize.width + minItemSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex: CGFloat = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}


// MARK: - UICollectionViewDataSource
extension CharacterBookVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterBookCVC.className, for: indexPath) as? CharacterBookCVC else { return UICollectionViewCell() }
        
        cell.setData(characterData: charcterBookData[indexPath.row], tagData: indexPath.row)
        cell.delegate = self
        
        if selectedIndex != -1 {
            if selectedIndex != indexPath.row {
                cell.chooseBtn.isHidden = true
            } else {
                cell.isClicked = true
                cell.setSelectedBtnUI()
            }
        } else {
            cell.isClicked = false
            cell.setDefaultBtnUI()
        }
        
        if indexPath.row == 0 {
            cell.chooseBtn.isHidden = true
        }
        return cell
    }
}

// MARK: - SendDataDelegate
extension CharacterBookVC: SendDataDelegate {
    func presentAlert() {
        guard let alert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC else { return }
        alert.showVeginAlert(vc: self, message: "미션을 중단하시겠습니까?", confirmBtnTitle: "확인", cancelBtnTitle: "취소", iconImg: "delete", type: .withDoubleBtn)
        alert.confirmBtn.press {
            self.requestStartAndStopMission(missionID: self.selectedIndex + 1)
            self.selectedIndex = -1
            self.characterBookCV.reloadData()
        }
        alert.cancelBtn.press {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func sendData(data: Int) {
        guard let alert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC else { return }
        alert.showVeginAlert(vc: self, message: "미션을 시작하시겠습니까?", confirmBtnTitle: "확인", cancelBtnTitle: "취소", iconImg: "cheerUp", type: .withDoubleBtn)
        alert.confirmBtn.press {
            self.requestStartAndStopMission(missionID: data + 1)
            self.selectedIndex = data
            self.characterBookCV.reloadData()
        }
        alert.cancelBtn.press {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - Network
extension CharacterBookVC {
    
    /// 캐릭터 미션 시작/중단 메서드
    private func requestStartAndStopMission(missionID: Int) {
        self.activityIndicator.startAnimating()
        HomeAPI.shared.requestStartMissionAPI(missionID: missionID) { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
            case .requestErr(let res):
                self.activityIndicator.stopAnimating()
                print(res)
            default:
                self.activityIndicator.stopAnimating()
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}

