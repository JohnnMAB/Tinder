//
//  DetailsPhotosCell.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 17/12/21.
//

import UIKit
class DetailsPhotosCell: UICollectionViewCell {
    
    //MARK: - Obejcts
    let descriptionLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.text = "Fotos recentes do instagram"
        return lbl
    }()
    let slidePhotosVC = SlidePhotosVC()
    
    //MARK: - Init Methods
    func prepareElements() {
        self.backgroundColor = .clear
        // Description
        self.addSubview(self.descriptionLabel)
        self.addBoundsConstraintsTo(subView: self.descriptionLabel, leading: 20, trailing: -20, top: 0, bottom: nil)
        // Slide
        self.addSubview(self.slidePhotosVC.view)
        self.addBoundsConstraintsTo(subView: self.slidePhotosVC.view, leading: 0, trailing: 0, top: nil, bottom: 0)
        self.addVerticalSpacingTo(subView1: self.descriptionLabel, subView2:self.slidePhotosVC.view , constant: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
