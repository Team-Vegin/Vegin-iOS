//
//  VeginBtn.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2022/02/28.
//

import UIKit

/**
 - Description:
 Vegin에서 자주 사용되는 bg: .darkMain/ font: .white 컬러의 둥근 모양 버튼
 폰트는 System-SemiBold: 12pt가 기본이고 이외에는 메서드를 통해 커스텀하여 사용
 
 - Note:
 - setButton: 버튼 기본 셋팅 변경
 - setTitle: 버튼 타이틀만 변경
 - changeColors: 버튼 배경색, 글씨색 변경
 */
class VeginBtn: UIButton {
    
    // MARK: Properties
    var isActivated: Bool = false {
        didSet {
            self.backgroundColor = self.isActivated ? activatedBgColor : normalBgColor
            self.setTitleColor(self.isActivated ? activatedFontColor : normalFontColor, for: .normal)
            self.isEnabled = isActivated
        }
    }
    
    private var normalBgColor: UIColor = .gray0
    private var normalFontColor: UIColor = .white
    private var activatedBgColor: UIColor = .darkMain
    var activatedFontColor: UIColor = .white
    
    init() {
        super.init(frame: .zero)
        setDefaultStyle()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setDefaultStyle()
    }
    
    // MARK: Private Methods
    /// 디폴트 버튼 스타일 설정
    private func setDefaultStyle() {
        self.makeRounded(cornerRadius: 12.adjusted)
        self.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        self.backgroundColor = self.normalBgColor
        self.tintColor = UIColor.darkMain
        self.setTitleColor(self.normalFontColor, for: .normal)
    }
    
    // MARK: Public Methods
    func setBtnColors(normalBgColor: UIColor, normalFontColor: UIColor, activatedBgColor: UIColor, activatedFontColor: UIColor) {
        self.normalBgColor = normalBgColor
        self.normalFontColor = normalFontColor
        self.activatedBgColor = activatedBgColor
        self.activatedFontColor = activatedFontColor
    }
    
    /// 버튼 타이틀과 스타일 변경 폰트 사이즈 adjusted 적용
    func setTitleWithStyle(title: String, size: CGFloat, weight: UIFont.Weight) {
        let font: UIFont
        
        switch weight {
        case .light:
            font = .systemFont(ofSize: size.adjusted, weight: .light)
        case .regular:
            font = .systemFont(ofSize: size.adjusted, weight: .regular)
        case .medium:
            font = .systemFont(ofSize: size.adjusted, weight: .medium)
        case .bold:
            font = .systemFont(ofSize: size.adjusted, weight: .bold)
        case .semibold:
            font = .systemFont(ofSize: size.adjusted, weight: .semibold)
        default:
            font = .systemFont(ofSize: size.adjusted, weight: .semibold)
        }
        
        self.titleLabel?.font = font
        self.setTitle(title, for: .normal)
    }
}
