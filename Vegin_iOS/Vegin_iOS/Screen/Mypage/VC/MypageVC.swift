//
//  MypageVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/11.
//

import UIKit
import Charts

class MypageVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var characterImgView: UIImageView!
    @IBOutlet weak var orientationContainerView: UIView!
    @IBOutlet weak var orientationLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var barGraphView: BarChartView!
    @IBOutlet weak var whiteViewHeight: NSLayoutConstraint!
    
    // MARK: Properties
    var dataEntries : [BarChartDataEntry] = [] {
        didSet {
            barGraphView.notifyDataSetChanged()
        }
    }// 실질적인 데이터
    var dataArray: [Int] = [1, 1, 1, 1, 1, 1]  // y축의 데이터가 될 data 배열
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setCharacterImg()
        getMypageInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCharacterImg()
        getMypageInfo()
    }
}

// MARK: - UI
extension MypageVC {
    
    private func configureUI() {
        orientationContainerView.makeRounded(cornerRadius: 10.adjusted)
        orientationLabel.sizeToFit()
        whiteViewHeight.constant = 603.adjustedH
    }
    
    /// 홈화면 적용 캐릭터에 따른 배경 캐릭터 이미지 적용 메서드
    private func setCharacterImg() {
        switch UserDefaults.standard.integer(forKey: UserDefaults.Keys.CharacterID) {
        case 1:
            characterImgView.image = UIImage(named: "mytomato")
        case 2:
            characterImgView.image = UIImage(named: "mycarrot")
        case 3:
            characterImgView.image = UIImage(named: "myonion")
        case 4:
            characterImgView.image = UIImage(named: "myspringOnion")
        case 5:
            characterImgView.image = UIImage(named: "mycabbage")
        case 6:
            characterImgView.image = UIImage(named: "mywaterMelon")
        case 7:
            characterImgView.image = UIImage(named: "mycorn")
        case 8:
            characterImgView.image = UIImage(named: "myblueberry")
        case 9:
            characterImgView.image = UIImage(named: "mystrawberry")
        case 10:
            characterImgView.image = UIImage(named: "mypumpkin")
        default:
            characterImgView.image = UIImage(named: "mytomato")
        }
    }
}

// MARK: - Custom Methods
extension MypageVC {
    
    /// 그래프 그리는 메서드
    private func setUpBarGraph(data: MyPageDataModel) {
        for i in 0...5 {
            dataArray[i] = data.dietCountList[i].count
        
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataArray[i]))
            dataEntries.append(dataEntry)
        }
        
        let format = NumberFormatter()
        format.numberStyle = .none
                
        let formatter = DefaultValueFormatter(formatter: format)
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        chartDataSet.colors = [.main] // 그래프 컬러 설정
        chartDataSet.highlightEnabled = false // 그래프 선택 되지 않도록
        barGraphView.doubleTapToZoomEnabled = false // 줌 되지 않도록
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = Double(0.60)
        
        barGraphView.data = chartData
        
        barGraphView.getAxis(.left).axisLineColor = .clear
        barGraphView.xAxis.labelTextColor = .clear
        barGraphView.xAxis.drawAxisLineEnabled = false
        barGraphView.xAxis.drawGridLinesEnabled = false
        barGraphView.rightAxis.drawAxisLineEnabled = false
        barGraphView.rightAxis.drawGridLinesEnabled = false
        barGraphView.rightAxis.drawLabelsEnabled = false
        barGraphView.leftAxis.drawAxisLineEnabled = false
        barGraphView.leftAxis.drawGridLinesEnabled = false
        barGraphView.leftAxis.drawLabelsEnabled = false
        barGraphView.legend.enabled = false
        barGraphView.barData?.setValueFormatter(formatter)

        barGraphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0) // 애니메이션 효과
        barGraphView.noDataText = "기록 데이터가 없습니다."
        barGraphView.noDataFont = .PretendardR(size: 12.adjusted)
        barGraphView.noDataTextColor = .defaultGray
    }
}

// MARK: - Network
extension MypageVC {
    /// 미션 리스트 현황 조회 메서드
    private func getMypageInfo() {
        self.activityIndicator.startAnimating()
        MyPageAPI.shared.getMypageInfoAPI() { networkResult in
            switch networkResult {
            case .success(let res):
                print(res)
                self.activityIndicator.stopAnimating()
                if let data = res as? MyPageDataModel {
                    print(data)
                    self.orientationLabel.text = data.orientation
                    self.nicknameLabel.text = data.nickname
                    self.dayCountLabel.text = "\(data.dayCount)일 째"
                    self.setUpBarGraph(data: data)
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
