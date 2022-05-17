//
//  EmptyViewTVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/05/17.
//

import UIKit

class EmptyViewTVC: BaseTVC {

    @IBOutlet weak var noPostLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureUI() {
        noPostLabel.sizeToFit()
    }
}
