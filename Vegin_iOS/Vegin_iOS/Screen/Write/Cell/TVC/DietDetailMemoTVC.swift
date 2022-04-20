//
//  DietDetailMemoTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/14.
//

import UIKit

class DietDetailMemoTVC: BaseTVC {

    // MARK: IBOutlet
    @IBOutlet weak var memoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(dietData: DietPostDataModel) {
        memoLabel.text = dietData.memo
    }
}
