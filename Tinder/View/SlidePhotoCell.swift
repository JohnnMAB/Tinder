//
//  SlidePhotoCell.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 18/12/21.
//

import UIKit

class SlidePhotoCell: UICollectionViewCell {
    
    //MARK: - Objects
    var photoImageView:UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8.0
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    //MARK: - Super Methods
    func prepareElements() {
        
        //Photo Image
        self.addSubview(self.photoImageView)
        self.addBoundsConstraintsTo(subView: self.photoImageView, leading: 0, trailing: 0, top: 0, bottom: 0)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareElements()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
