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
    var missionListData: [MissionListResModel] = []
    var isDoingMission: Bool = false
    var isFirst: Bool = true // 성공한 미션 하나도 없으면 true 아니면 false
    var cellTagDelegate: SendDataDelegate?
    
    let cellSize = CGSize(width: UIScreen.main.bounds.width * (276/375), height: UIScreen.main.bounds.width * (276/375) * (640/276))
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
        getMissionListStatus()
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
            CharacterBookData(hiddenCharacterImgName: "Tomavi_1", myCharacterImgName: "Tomavi_1", characterName: "토마비", firstMission: "비긴 설치하기", secondMission: "비긴 회원가입하기", thirdMission: "처음 접속하기", characterExplanation: "성실한 토마토.\n 베푸는 것을 좋아하며 착하다."),
            CharacterBookData(hiddenCharacterImgName: "Hidden_Dangvi", myCharacterImgName: "carrot", characterName: "당비", firstMission: "식단 기록 1번 하기", secondMission: "레시피 피드 게시글에 느낌 1번 달기", thirdMission: "플렉시테리언 식단 2번 기록하기", characterExplanation: "귀찮은 당근.\n시크하게 열심히 충고해주는 편."),
            CharacterBookData(hiddenCharacterImgName: "Hidden_Onion", myCharacterImgName: "onion", characterName: "양비", firstMission: "식단 기록 2일 하기", secondMission: "플렉시테리언 식단 기록 3번 하기", thirdMission: "생활 피드에 게시글 작성하기", characterExplanation: "소심한 양파.\n걱정이 많아서 꼼꼼하게 코칭해준다."),
            CharacterBookData(hiddenCharacterImgName: "Hidden_Pavi", myCharacterImgName: "springOnion", characterName: "파비", firstMission: "피드에 글 1번 올리기", secondMission: "피드 게시글에 느낌 달기", thirdMission: "하루에 2번 식단 기록하기", characterExplanation: "엄격한 대파.\n본심은 따뜻한 노력’파’."),
            CharacterBookData(hiddenCharacterImgName: "Hidden_Cabbage", myCharacterImgName: "cabbage", characterName: "양배비", firstMission: "피드에 글 2번 올리기", secondMission: "꿀팁 피드 게시글 작성하기", thirdMission: "당비 획득하기", characterExplanation: "상냥한 양배추.\n당비를 짝사랑하는 친절한 메이트."),
            CharacterBookData(hiddenCharacterImgName: "Hidden_Suvi", myCharacterImgName: "waterMelon", characterName: "수비", firstMission: "락토-오보 식단 1번 기록하기", secondMission: "폴로 식단 1번 기록하기", thirdMission: "완전 채식 식단 1번 기록하기", characterExplanation: "까칠한 수박.\n틱틱거리지만 챙겨주는 것을 좋아한다."),
            CharacterBookData(hiddenCharacterImgName: "Hidden_Oksuvi", myCharacterImgName: "corn", characterName: "옥수비", firstMission: "완전 채식 식단 1번 기록하기", secondMission: "하루 2번 식단 기록하기", thirdMission: "페스코 식단 2번 기록하기", characterExplanation: "느긋한 옥수수.\n뺀질거리지만 유머감각이 좋다."),
            CharacterBookData(hiddenCharacterImgName: "Hidden_Bluevi", myCharacterImgName: "blueberry", characterName: "블루비", firstMission: "하루 3번 식단 기록하기", secondMission: "수비 획득하기", thirdMission: "맛집 피드 게시글 작성하기", characterExplanation: "영악한 블루베리.\n얄밉지만 미워할 수 없는 천재."),
            CharacterBookData(hiddenCharacterImgName: "Hidden_Ddalvi", myCharacterImgName: "strawberry", characterName: "딸비", firstMission: "식단 기록 10번 이상하기", secondMission: "블루비 획득하기", thirdMission: "완전 채식 3일 이상 기록하기", characterExplanation: "무뚝뚝한 딸기.\n관심없어 보이지만 수줍어서 그런 것이다."),
            CharacterBookData(hiddenCharacterImgName: "Hidden_Hovi", myCharacterImgName: "pumpkin", characterName: "호비", firstMission: "다른 캐릭터 모두 획득하기", secondMission: "식단 기록 30번 이상하기", thirdMission: "피드 모든 카테고리 게시글 작성하기", characterExplanation: "호기심 많은 단호박.\n아직 애기라 발음이 잘 안된다.")
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
        
        if missionListData.count > 0 {
            cell.setData(characterData: charcterBookData[indexPath.row], tagData: indexPath.row, missionData: missionListData[indexPath.row])
            
            for i in 0...missionListData.count - 1 {
                if !missionListData[i].inProgress {
                    isDoingMission = false
                    if missionListData[i].progress == [1, 1, 1] {
                        if i != 0 {
                            isFirst = false // 완료한 미션이 하나라도 있음
                        } else {
                            isFirst = true
                        }
                    }
                } else {
                    isDoingMission = true
                    break
                }
            }
            
            /// 획득 완료한 캐릭터
            if !missionListData[indexPath.row].inProgress && missionListData[indexPath.row].progress == [1, 1, 1] {
                cell.setSelectCharacterBtnUI()
                cell.isFinished = true
            }
            
            // 미션 중일때
            if isDoingMission {
                if missionListData[indexPath.row].inProgress { // [1,1,1] 아니면 미션 중단하기 버튼 떠있어야함
                    cell.chooseBtn.isHidden = false
                    if missionListData[indexPath.row].progress == [1, 1, 1] { // 캐릭터 선택하기 버튼
                        cell.setSelectCharacterBtnUI()
                        cell.isFinished = true
                    } else {
                        cell.isClicked = true
                        cell.setDoingMissionBtnUI() // 미션 중단하기 버튼
                    }
                } else { // 미션 중이지 않은 셀들의 버튼 처리
                    if missionListData[indexPath.row].progress != [1, 1, 1] {
                        cell.chooseBtn.isHidden = true
                    }
                }
            // 미션 중이지 않을때
            } else {
                if !missionListData[indexPath.row].inProgress { // false인 애들
                    if missionListData[indexPath.row].progress == [1, 1, 1] { //이미 미션 달성한애들
                        cell.chooseBtn.isHidden = false
                        cell.setSelectCharacterBtnUI()
                        cell.isFinished = true
                    } else { // 아직 달성 못한 애들
                        cell.isFinished = false
                        cell.setDefaultBtnUI()
                        cell.isClicked = false
                    }
                }
            }
        }
        cell.delegate = self

        /// 디폴트 캐릭터 (토마비)
        if indexPath.row == 0 {
            cell.chooseBtn.isHidden = isFirst ? true : false
            cell.setSelectCharacterBtnUI()
            cell.isFinished = true
            cell.isClicked = false
        }
        
        /// 선택된 캐릭터
        if indexPath.row + 1 == UserDefaults.standard.integer(forKey: UserDefaults.Keys.CharacterID) {
            cell.setSelectedCharacterBtnUI()
            cell.isFinished = true
        }
        
        return cell
    }
}

// MARK: - SendDataDelegate
extension CharacterBookVC: SendDataDelegate {
    
    /// 캐릭터 선택하기
    func changeCharacter(data: Int) {
        guard let alert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC,
              let confirmAlert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC else { return }
        
        alert.showVeginAlert(vc: self, message: "캐릭터를 적용하시겠습니까?", confirmBtnTitle: "확인", cancelBtnTitle: "취소", iconImg: "_smile", type: .withDoubleBtn)
        alert.confirmBtn.press {
            self.selectCharacter(characterID: data + 1)
            confirmAlert.showVeginAlert(vc: self, message: "캐릭터가 적용되었습니다!", confirmBtnTitle: "확인", cancelBtnTitle: "", iconImg: "_smile", type: .withSingleBtn)
            confirmAlert.confirmBtn.press {
                self.getMissionListStatus()
                confirmAlert.dismiss(animated: true)
            }
        }
        alert.cancelBtn.press {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    /// 미션 중단하기
    func presentAlert(data: Int) {
        guard let alert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC,
              let confirmAlert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC else { return }
        
        alert.showVeginAlert(vc: self, message: "미션을 중단하시겠습니까?", confirmBtnTitle: "확인", cancelBtnTitle: "취소", iconImg: "delete", type: .withDoubleBtn)
        alert.confirmBtn.press {
            self.requestStartAndStopMission(missionID: data + 1)
            confirmAlert.showVeginAlert(vc: self, message: "미션이 중단되었습니다.", confirmBtnTitle: "확인", cancelBtnTitle: "", iconImg: "delete", type: .withSingleBtn)
            confirmAlert.confirmBtn.press {
                self.getMissionListStatus()
                confirmAlert.dismiss(animated: true)
            }
        }
        alert.cancelBtn.press {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    /// 미션 시작하기
    func sendData(data: Int) {
        guard let alert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC,
              let confirmAlert = Bundle.main.loadNibNamed(VeginAlertVC.className, owner: self, options: nil)?.first as? VeginAlertVC else { return }
        alert.showVeginAlert(vc: self, message: "미션을 시작하시겠습니까?", confirmBtnTitle: "확인", cancelBtnTitle: "취소", iconImg: "cheerUp", type: .withDoubleBtn)
        alert.confirmBtn.press {
            self.requestStartAndStopMission(missionID: data + 1)
            confirmAlert.showVeginAlert(vc: self, message: "미션이 시작되었습니다.", confirmBtnTitle: "확인", cancelBtnTitle: "", iconImg: "cheerUp", type: .withSingleBtn)
            confirmAlert.confirmBtn.press {
                self.getMissionListStatus()
                confirmAlert.dismiss(animated: true)
            }
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
                DispatchQueue.main.async {
                    self.characterBookCV.reloadData()
                }
            case .requestErr(let res):
                self.activityIndicator.stopAnimating()
                print(res)
            default:
                self.activityIndicator.stopAnimating()
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
    
    /// 미션 리스트 현황 조회 메서드
    private func getMissionListStatus() {
        self.activityIndicator.startAnimating()
        HomeAPI.shared.getMissionListStatusAPI() { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? [MissionListResModel] {
                    print(data)
                    self.missionListData.removeAll()
                    self.missionListData.append(MissionListResModel(missionID: -1, characterID: 1, progress: [1, 1, 1], inProgress: false, randomText: 1))
                    self.missionListData.append(contentsOf: data)
                    DispatchQueue.main.async {
                        self.characterBookCV.reloadData()
                    }
                }
            case .requestErr(let res):
                self.activityIndicator.stopAnimating()
                print(res)
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.activityIndicator.stopAnimating()
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
    
    /// 캐릭터 선택하기 메서드
    private func selectCharacter(characterID: Int) {
        self.activityIndicator.startAnimating()
        HomeAPI.shared.selectCharacterAPI(characterID: characterID) { networkResult in
            switch networkResult {
            case .success(let res):
                self.activityIndicator.stopAnimating()
                if let data = res as? CharacterSelectResModel {
                    print(data)
                    UserDefaults.standard.set(data.character, forKey: UserDefaults.Keys.CharacterID)
                    DispatchQueue.main.async {
                        self.characterBookCV.reloadData()
                    }
                }
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

