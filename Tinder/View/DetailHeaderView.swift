//
//  DetailHeaderView.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 17/12/21.
//

import UIKit

class DetailHeaderVIew: UICollectionReusableView {
    
    
    //MARK: - Properties
    var user: User? {
        didSet {
            if let user = user {
                photoImageView.image = UIImage(named: user.photo)
            }
        }
    }
    
    //MARK: - Objects
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    //MARK: - Init Methods
    func prepareElements(){
        self.addSubview(self.photoImageView)
        self.addFullBoundsConstraintsTo(subView: self.photoImageView, constant: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareElements()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has been implemented")
    }
}
