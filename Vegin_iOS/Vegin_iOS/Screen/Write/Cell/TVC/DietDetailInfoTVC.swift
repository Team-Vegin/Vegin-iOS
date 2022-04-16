//
//  DietDetailInfoTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/14.
//

import UIKit

class DietDetailInfoTVC: BaseTVC {

    // MARK: IBOutlet
    @IBOutlet weak var mealTimeLabel: UILabel!
    @IBOutlet weak var mealAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(dietData: DietPostDataModel) {
        if dietData.mealTime == 1 {
            mealTimeLabel.text = "아침"
        } else if dietData.mealTime == 2 {
            mealTimeLabel.text = "아점"
        } else if dietData.mealTime == 3 {
            mealTimeLabel.text = "점심"
        } else if dietData.mealTime == 4 {
            mealTimeLabel.text = "점저"
        } else if dietData.mealTime == 5 {
            mealTimeLabel.text = "저녁"
        }
        
        if dietData.amount == 1 {
            mealAmountLabel.text = "조금"
        } else if dietData.amount == 2 {
            mealAmountLabel.text = "보통"
        } else if dietData.amount == 3 {
            mealAmountLabel.text = "많이"
        }
    }
    
}
