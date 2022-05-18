//
//  CalendarVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/11.
//

import UIKit

import FSCalendar

class CalendarVC: BaseVC {

    // MARK: - UI Component Part
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var writeBtn: VeginBtn! {
        didSet {
            writeBtn.isActivated = true
            writeBtn.setTitleWithStyle(title: "기록하기", size: 14, weight: .bold)
        }
    }
    @IBOutlet weak var checkBtn: VeginBtn! {
        didSet {
            checkBtn.isActivated = true
            checkBtn.setTitleWithStyle(title: "확인하기", size: 14, weight: .bold)
        }
    }
    @IBOutlet weak var firstListView: UIView!
    @IBOutlet weak var secondListView: UIView!
    
    // MARK: - Vars & Lets Part
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    var calendarDataArray: [DietCalendarResModel] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getEmojiList(year: getYear(date: self.today), month: getMonth(date: self.today))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getEmojiList(year: getYear(date: calendar.currentPage), month: getMonth(date: calendar.currentPage))
        setUI()
        setCalendarUI()
        setCalendarDelegate()
    }
    
    // MARK: - IBAction Part
    
    @IBAction func prevButtonTapped(_ sender: UIButton) {
        scrollCurrentPage(isPrev: true)
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        scrollCurrentPage(isPrev: false)
    }
    
    @IBAction func tapWriteBtn(_ sender: UIButton) {
        let calendarTabSB = UIStoryboard.init(name: "WriteSB", bundle: nil)
        guard let nextVC = calendarTabSB.instantiateViewController(withIdentifier: WriteVC.className) as? WriteVC else { return }
        
        nextVC.selectedDate = getDayDate(date: calendar.selectedDate ?? today)
        nextVC.writeDate = getSelectedDate(date: calendar.selectedDate ?? today)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func tapDietListBtn(_ sender: UIButton) {
        let dietListSB = UIStoryboard.init(name: "DietListSB", bundle: nil)
        guard let nextVC = dietListSB.instantiateViewController(withIdentifier: DietListVC.className) as? DietListVC else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    // MARK: - Custom Method Part
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        /// 날짜 하나만 선택가능하도록
        if calendar.selectedDates.count > 1 {
            return false
        } else {
            return true
        }
    }
    
    private func setUI() {
        firstListView.layer.cornerRadius = 19
        secondListView.layer.cornerRadius = 19
    }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1

        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
    
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
        getEmojiList(year: getYear(date: self.currentPage ?? self.today), month: getMonth(date: self.currentPage ?? self.today))
    }
}

// MARK: - Extension
extension CalendarVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func setCalendarDelegate() {
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    func setCalendarUI() {
        calendar.calendarHeaderView.isHidden = true
        calendar.headerHeight = 0
        calendar.scope = .month
        
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = .gray
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.todayColor = .main
        calendar.appearance.titleTodayColor = .darkMain
        calendar.appearance.selectionColor = .main
        calendar.appearance.titleSelectionColor = .black
        
        let monthData = getMonthDate(date: calendar.currentPage)
        self.headerLabel.text = monthData
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let monthData = getMonthDate(date: calendar.currentPage)
        self.headerLabel.text = monthData
        getEmojiList(year: getYear(date: calendar.currentPage), month: getMonth(date: calendar.currentPage))
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        if calendarDataArray.count != 0 {
            for i in 0...calendarDataArray.count - 1 {
                let targetDate = getSelectedDate(date: date)
            
                if targetDate == calendarDataArray[i].date.prefix(10) {
                    switch calendarDataArray[i].meal {
                    case 1:
                        return UIImage(named: "level1")
                    case 2:
                        return UIImage(named: "level2")
                    case 3:
                        return UIImage(named: "level3")
                    case 4:
                        return UIImage(named: "level4")
                    case 5:
                        return UIImage(named: "level5")
                    case 6:
                        return UIImage(named: "level6")
                    default:
                        break
                    }
                }
            }
        }
        return UIImage()
    }
}

// MARK: - Network
extension CalendarVC {

    /// 캘린더 조회 메서드
    private func getEmojiList(year: Int, month: Int) {
        self.activityIndicator.startAnimating()
        DietAPI.shared.getDietCalendarDataAPI(year: year, month: month) { networkResult in
            switch networkResult {
            case .success(let res):
                self.activityIndicator.stopAnimating()
                self.calendarDataArray.removeAll()
                if let data = res as? [DietCalendarResModel], data.count != 0 {
                    print(data)
                    for i in 0...data.count - 1 {
                        self.calendarDataArray.append(DietCalendarResModel(date: data[i].date, meal: data[i].meal))
                    }
                    DispatchQueue.main.async {
                        self.calendar.reloadData()
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
