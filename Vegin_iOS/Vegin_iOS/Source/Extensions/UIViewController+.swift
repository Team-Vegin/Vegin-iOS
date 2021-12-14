//
//  UIViewController+.swift
//  Vegin_iOS
//
//  Created by EUNJU on 2021/11/16.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
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
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
