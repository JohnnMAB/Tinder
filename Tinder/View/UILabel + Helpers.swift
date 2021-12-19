//
//  UILabel + Helpers.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 14/12/21.
//

import UIKit

extension UILabel {
    static func textLabel (_ size: CGFloat, textColor: UIColor = .black, numberOFLines: Int = 1 ) ->  UILabel {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: size)
        lbl.textColor = textColor
        lbl.numberOfLines = numberOFLines
        return lbl
    }
    static func textBoldLabel (_ size: CGFloat, textColor: UIColor = .black, numberOFLines: Int = 1 ) ->  UILabel {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: size)
        lbl.textColor = textColor
        lbl.numberOfLines = numberOFLines
        return lbl
    }
    
    func addShadow () {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.masksToBounds = true
    }
}
