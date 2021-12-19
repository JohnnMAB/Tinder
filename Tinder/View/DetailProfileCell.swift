//
//  DetailProfileCell.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 17/12/21.
//

import UIKit


class DetailProfileCell: UICollectionViewCell {
    
    //MARK: - Properties
    var user: User? {
        didSet {
            if let user = user {
                nameLabel.text = user.name
                ageLabel.text = String(user.age)
                descriptionLabel.text = user.description
            }
        }
    }
    
    
    //MARK: - Objects
    let nameLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 32)
        return lbl
    }()
    let ageLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 28)
        return lbl
    }()
    let descriptionLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.numberOfLines = 2
        return lbl
    }()
    let stackView0:UIStackView = {
        let svw = UIStackView()
        svw.spacing = 12
        return svw
    }()
    let stackView:UIStackView = {
        let svw = UIStackView()
        svw.distribution = .fillEqually
        svw.axis = .vertical
        return svw
    }()
    let emptyView: UIView = {
        let vw = UIView()
        return vw
    }()
    //MARK: -Init Mehtods
    func prepareElements() {
        // Stack0
        self.stackView0.addArrangedSubview(self.nameLabel)
        self.stackView0.addArrangedSubview(self.ageLabel)
        self.stackView0.addArrangedSubview(self.emptyView)
        // StackView
        self.addSubview(self.stackView)
        self.addBoundsConstraintsTo(subView: self.stackView, leading: 20, trailing: -20, top: 20, bottom: -20)
        self.stackView.addArrangedSubview(self.stackView0)
        self.stackView.addArrangedSubview(self.descriptionLabel)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
