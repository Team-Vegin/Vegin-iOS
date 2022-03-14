//
//  DietListVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/01.
//

import UIKit
import FSCalendar

class DietListVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var listCalendar: FSCalendar!
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dietListTV: UITableView!
    
    // MARK: Properties
    var postList: [DietPostData] = []
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToNaviBar()
        registerTVC()
        setUpTV()
        initPostList()
        setUpCalendar()
        configureCalendarUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
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
    }
    
    private func setUpTV() {
        dietListTV.dataSource = self
        dietListTV.delegate = self
    }
    
    private func initPostList() {
        postList.append(contentsOf: [
            DietPostData.init(title: "아침", content: "오늘은 샐러드를 먹었다. 맛있었다. 다음에는 좀 더 종류가 다양한 것이 들어가 있는 샐러드를 먹고 싶고 친구들에게 이 가게를 추천하 오늘은 샐러드를 먹었다. 맛있었다.", thumbnailImgName: "Rectangle 293", iconImgName: "level1"),
            DietPostData.init(title: "점심", content: "오늘은 샐러드를 먹었다. 맛있었다. 다음에는 좀 더 종류가 다양한 것이 들어가 있는 샐러드를 먹고 싶고 친구들에게 이 가게를 추천하 오늘은 샐러드를 먹었다. 맛있었다.", thumbnailImgName: "Rectangle 293", iconImgName: "level2"),
            DietPostData.init(title: "저녁", content: "오늘은 샐러드를 먹었다. 맛있었다. 다음에는 좀 더 종류가 다양한 것이 들어가 있는 샐러드를 먹고 싶고 친구들에게 이 가게를 추천하 오늘은 샐러드를 먹었다. 맛있었다.", thumbnailImgName: "Rectangle 293", iconImgName: "level1")
        ])
    }
}

// MARK: - UITableViewDelegate
extension DietListVC: UITableViewDelegate {
    
    /// cell 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - UITableViewDataSource
extension DietListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DietListTVC.className) as? DietListTVC else { return UITableViewCell() }
        
        cell.setData(postData: postList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = UIStoryboard.init(name: Identifiers.DietDetailSB, bundle: nil).instantiateViewController(withIdentifier: DietDetailVC.className) as? DietDetailVC else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
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
        return false // 날짜 선택 안되도록
    }
    
}
