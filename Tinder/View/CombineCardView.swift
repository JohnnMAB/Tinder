//
//  CombineCardView.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 14/12/21.
//

import UIKit

class CombineCardView: UIView {
    
    //MARK: - Properties
    var user: User? {
        didSet{
            if let user = user {
                photoImageView.image = UIImage(named: user.photo)
                titleLabel.text = user.name
                subtitleLabel.text = String(user.age)
                undertitleLabel.text = user.description
            }
        }
    }
    

    var callback:((User) -> Void)?
  
    
    //MARK: - Objects
    let titleLabel: UILabel = .textBoldLabel(32, textColor: .white)
    let subtitleLabel: UILabel = .textLabel(28, textColor: .white)
    let undertitleLabel: UILabel = .textLabel(18, textColor: .white, numberOFLines: 2)
    let emptyView = UIView()
    let photoImageView: UIImageView = .photoImageView()
    let ivDeslike: UIImageView = .iconCard(named: "card-deslike")
    let ivLike: UIImageView = .iconCard(named: "card-like")
    
    let stackView0: UIStackView = {
        let vw = UIStackView()
        vw.spacing = 15
        return vw
    }()
    let stackView: UIStackView = {
        let vw = UIStackView()
        vw.distribution = .fillEqually
        vw.axis = .vertical
        vw.isUserInteractionEnabled = false
        return vw
    }()
    
    //MARK: - Methods
    @objc func didTap() {
        
        if let user = self.user {
            self.callback?(user)
            
        }
    }
    
    //MARK: - Init Methods
    private func prepareElements() {
        
        let userTap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.addSubview(self.photoImageView)
        self.addFullBoundsConstraintsTo(subView: photoImageView, constant: 0)
        // Stack View0
        self.stackView0.addArrangedSubview(self.titleLabel)
        self.stackView0.addArrangedSubview(self.subtitleLabel)
        self.stackView0.addArrangedSubview(self.emptyView)
        // Stack View
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.stackView0)
        self.stackView.addArrangedSubview(self.undertitleLabel)
        self.addBoundsConstraintsTo(subView: self.stackView, leading: 20, trailing: -20, top: nil, bottom: -15)
        self.stackView.isUserInteractionEnabled = true
        self.stackView.addGestureRecognizer(userTap)
        // Labels
        self.titleLabel.addShadow()
        self.subtitleLabel.addShadow()
        self.undertitleLabel.addShadow()
        // Deslike
        self.addSubview(self.ivDeslike)
        self.addBoundsConstraintsTo(subView: self.ivDeslike, leading: nil, trailing: -20, top: 20, bottom: nil)
        self.ivDeslike.addWidthConstraint(70)
        self.ivDeslike.addHeightConstraint(70)
        // Like
        self.addSubview(self.ivLike)
        self.addBoundsConstraintsTo(subView: self.ivLike, leading: 20, trailing: nil, top: 20, bottom: nil)
        self.ivLike.addWidthConstraint(70)
        self.ivLike.addHeightConstraint(70)
        

        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareElements()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
}
