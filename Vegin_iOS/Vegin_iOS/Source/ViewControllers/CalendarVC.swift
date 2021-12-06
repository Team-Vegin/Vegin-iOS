//
//  CalendarVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/11.
//

import UIKit

import FSCalendar

class CalendarVC: UIViewController {

    // MARK: - UI Component Part
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var firstListView: UIView!
    @IBOutlet weak var secondListView: UIView!
    
    // MARK: - Vars & Lets Part
    
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()

    // MARK: - Life Cycle Part
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        setUI()
        setCalendarUI()
        setCalendarDelegate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction Part
    
    @IBAction func prevButtonTapped(_ sender: UIButton) {
        scrollCurrentPage(isPrev: true)
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        scrollCurrentPage(isPrev: false)
    }
    
    @IBAction func touchUpToGoWriteVC(_ sender: Any) {
        let calendarTabSB = UIStoryboard.init(name: "CalendarTab", bundle: nil)
        guard let nextVC = calendarTabSB.instantiateViewController(withIdentifier: WriteVC.className) as? WriteVC else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - Custom Method Part
    
    func getMonthDate(date: Date) -> String{
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy년 M월"
        return df.string(from: date)
    }
    
    func getDayDate(date: Date) -> String{
            let df = DateFormatter()
            df.locale = Locale(identifier: "ko_KR")
            df.dateFormat = "yyyy년 M월 dd일"
            return df.string(from: date)
        }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false // 날짜 선택 안되도록
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
    }
}

// MARK: - Extension Part

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
        calendar.appearance.todayColor = UIColor(red: 194/255, green: 225/255, blue: 165/255, alpha: 1)
        calendar.appearance.titleTodayColor = UIColor(red: 82/255, green: 153/255, blue: 90/255, alpha: 1)
        
        let monthData = getMonthDate(date: calendar.currentPage)
        self.headerLabel.text = monthData
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let monthData = getMonthDate(date: calendar.currentPage)
        self.headerLabel.text = monthData
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let eventDate = getDayDate(date: date)

        if eventDate == "2021년 11월 15일" {
            return UIImage(named: "level6")
        } else if eventDate == "2021년 11월 21일" {
            return UIImage(named: "level1")
        } else if eventDate == "2021년 12월 3일" {
            return UIImage(named: "level2")
        } else { return nil }
        
        
     }
        
}
