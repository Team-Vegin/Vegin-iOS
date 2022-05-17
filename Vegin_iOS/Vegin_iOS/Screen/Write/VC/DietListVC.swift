//
//  DietListVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/01.
//

import UIKit
import FSCalendar

class DietListVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var listCalendar: FSCalendar!
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dietListTV: UITableView!
    
    // MARK: Properties
    var postList: [DietListDataModel] = []
    private var currentPage: Date?
    private var selectedDate: Date?
    private lazy var today: Date = {
        return Date()
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToNaviBar()
        registerTVC()
        setUpTV()
        setUpCalendar()
        configureCalendarUI()
        getDayDietList(date: getSelectedDate(date: today))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        getDayDietList(date: getSelectedDate(date: selectedDate ?? today))
    }
    
    // MARK: IBAction
    @IBAction func tapLeftNaviBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapPrevBtn(_ sender: UIButton) {
        scrollCurrentPage(isPrev: true)
    }
    @IBAction func tapNextBtn(_ sender: UIButton) {
        scrollCurrentPage(isPrev: false)
    }
    
}

// MARK: - UI
extension DietListVC {
    
    /// NaviBar dropShadow 설정 함수
    private func addShadowToNaviBar() {
        naviView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        naviView.layer.shadowOffset = CGSize(width: 0, height: 4)
        naviView.layer.shadowRadius = 8
        naviView.layer.shadowOpacity = 1
        naviView.layer.masksToBounds = false
    }
}

// MARK: - Custom Methods
extension DietListVC {
    private func registerTVC() {
        DietListTVC.register(target: dietListTV)
        EmptyViewTVC.register(target: dietListTV)
    }
    
    private func setUpTV() {
        dietListTV.dataSource = self
        dietListTV.delegate = self
    }
}

// MARK: - UITableViewDelegate
extension DietListVC: UITableViewDelegate {
    
    /// cell 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if postList.isEmpty {
            return 400.adjustedH
        } else {
            return 140.adjustedH
        }
    }
}

// MARK: - UITableViewDataSource
extension DietListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if postList.isEmpty {
            return 1
        } else {
            return postList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DietListTVC.className) as? DietListTVC,
              let emptycell = tableView.dequeueReusableCell(withIdentifier: EmptyViewTVC.className) as? EmptyViewTVC else { return UITableViewCell() }
        if postList.isEmpty {
            return emptycell
        } else {
            cell.setData(postData: postList[indexPath.row])
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !postList.isEmpty {
            guard let nextVC = UIStoryboard.init(name: Identifiers.DietDetailSB, bundle: nil).instantiateViewController(withIdentifier: DietDetailVC.className) as? DietDetailVC else { return }
            
            nextVC.selectedDate = getDayDate(date: listCalendar.selectedDate ?? today )
            nextVC.postId = postList[indexPath.row].postID
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

// MARK: - Custom FSCalendar
extension DietListVC: FSCalendarDelegate, FSCalendarDataSource {
    private func setUpCalendar() {
        listCalendar.delegate = self
        listCalendar.dataSource = self
    }
    
    private func configureCalendarUI() {
        listCalendar.headerHeight = 0
        listCalendar.scope = .week // 주간
        listCalendar.appearance.titleDefaultColor = .black
        listCalendar.appearance.headerTitleColor = .black
        listCalendar.appearance.weekdayTextColor = .gray
        listCalendar.appearance.headerMinimumDissolvedAlpha = 0
        listCalendar.appearance.todayColor = .main
        listCalendar.appearance.titleTodayColor = .darkMain
        listCalendar.appearance.calendar.weekdayHeight = 20
        listCalendar.appearance.selectionColor = .main
        listCalendar.appearance.titleSelectionColor = .black
        
        let monthData = getMonthDate(date: listCalendar.currentPage)
        self.headerLabel.text = monthData
    }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = isPrev ? -7 : 7
        
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.listCalendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let monthData = getMonthDate(date: calendar.currentPage)
        self.headerLabel.text = monthData
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        /// 날짜 하나만 선택가능하도록
        if calendar.selectedDates.count > 1 {
            return false
        } else {
            return true
        }
    }
    
    /// 날짜 선택 시 호출
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.getDayDietList(date: getSelectedDate(date: date))
        self.selectedDate = date
    }
}

// MARK: - Network
extension DietListVC {
    
    /// 식단 리스트 조회 메서드
    private func getDayDietList(date: String) {
        self.activityIndicator.startAnimating()
        DietAPI.shared.getDietListAPI(date: date) { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? [DietListDataModel] {
                    DispatchQueue.main.async {
                        self.postList = data
                        self.dietListTV.reloadData()
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
}
