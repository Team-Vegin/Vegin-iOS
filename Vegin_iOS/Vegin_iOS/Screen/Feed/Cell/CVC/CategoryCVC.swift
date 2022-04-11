//
//  CategoryCVC.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/03/14.
//

import UIKit

class CategoryCVC: BaseCVC {

    // MARK: IBOutlet
    @IBOutlet weak var categoryLabel: UILabel!
    
    // MARK: Properties
    override var isSelected: Bool {
        didSet {
            if isSelected {
                categoryLabel.backgroundColor = .darkMain
                categoryLabel.textColor = .white
                categoryLabel.font = .PretendardSB(size: 14)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendTagData"), object: categoryLabel.text)
            } else {
                categoryLabel.backgroundColor = .defaultGray
                categoryLabel.textColor = .defaultTextGray
                categoryLabel.font = .PretendardR(size: 14)
            }
        }
    }
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: Custom Methods
    private func configureUI() {
        categoryLabel.backgroundColor = .defaultGray
        categoryLabel.makeRounded(cornerRadius: 14.adjusted)
        categoryLabel.textColor = .defaultTextGray
    }
    
    func setCategoryData(categoryData: String) {
        categoryLabel.text = categoryData
    }
}
