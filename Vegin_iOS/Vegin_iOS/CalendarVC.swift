//
//  CalendarVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/11.
//

import UIKit

import FSCalendar

class CalendarVC: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var firstListView: UIView!
    @IBOutlet weak var secondListView: UIView!
    @IBOutlet weak var thirdListView: UIView!
    
    
    
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy년 M월"
        return df
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
        setCalendarUI()
        setCalendarDelegate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func prevButtonTapped(_ sender: UIButton) {
        scrollCurrentPage(isPrev: true)
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        scrollCurrentPage(isPrev: false)
    }
    
    private func setUI() {
        firstListView.layer.cornerRadius = 19
        secondListView.layer.cornerRadius = 19
        thirdListView.layer.cornerRadius = 19
    }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
}

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
        calendar.appearance.borderRadius = 0.2
        
        headerLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.headerLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    
}
