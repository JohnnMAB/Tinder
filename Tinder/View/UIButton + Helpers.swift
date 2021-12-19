//
//  UIButton + Helpers.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 14/12/21.
//

import UIKit

extension UIButton {
    static func iconFooter(named: String) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: named), for: .normal)
        btn.backgroundColor = .white
        
        btn.layer.cornerRadius = 32.0
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 3.0
        btn.layer.shadowOpacity = 0.1
        btn.layer.shadowOffset = CGSize(width: 1.0, height:  1.0)
        btn.layer.masksToBounds = false
        
        btn.clipsToBounds =  true
        return btn
    }
    
    static func iconMenu(named: String) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: named), for: .normal)
        return btn
    }
}
