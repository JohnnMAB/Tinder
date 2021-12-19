//
//  UIImageView + Helpers.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 14/12/21.
//

import UIKit

extension UIImageView {
    static func photoImageView (named: String? = nil) -> UIImageView {
        let iv = UIImageView()
        if let named = named {
            iv.image = UIImage(named: named)
        }
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }
    
    static func iconCard (named: String) -> UIImageView {
        let iv = UIImageView()
        iv.image = UIImage(named: named)
        iv.alpha = 0.0
        return iv
    }
}
