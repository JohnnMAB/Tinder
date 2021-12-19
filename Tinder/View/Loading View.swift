//
//  Loading View.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 15/12/21.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - Objects
    let loadingView: UIView = {
        let vw = UIView()
        vw.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        vw.backgroundColor = UIColor(red: 218/255, green: 99/255, blue: 111/255, alpha: 1)
        vw.layer.cornerRadius = 50
        vw.layer.borderWidth = 1.0
        vw.layer.borderColor = UIColor.red.cgColor
        return vw
    }()
    
    let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        iv.layer.cornerRadius = 50
        iv.layer.borderWidth = 5.0
        iv.layer.borderColor = UIColor.white.cgColor
        iv.clipsToBounds = true
        iv.image = UIImage(named: "perfil")
        return iv
    }()
    
    // MARK: - Methods
    func animated () {
        
        UIView.animate(withDuration: 1.3) {
            
            
            self.loadingView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
            self.loadingView.layer.cornerRadius = 125
            self.loadingView.center = self.center
            self.loadingView.alpha = 0.3
            
        } completion: { (_)  in
            self.loadingView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.loadingView.layer.cornerRadius = 50
            self.loadingView.center = self.center
            self.loadingView.alpha = 1.0
            
            self.animated()
        }

    }
    
    
    // MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.loadingView)
        loadingView.center = center
        
        self.addSubview(self.profileImage)
        profileImage.center = center
        
        self.animated()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
