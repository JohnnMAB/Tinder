//
//  CombineVC.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 14/12/21.
//

import UIKit

class CombineVC:UIViewController {
    
    enum Actions {
        case like
        case deslike
        case superlike
    }
    
    //MARK: - Objects
    var users: [User] = []
    var profileBtn: UIButton = .iconMenu(named: "icone-perfil")
    var chatBtn: UIButton = .iconMenu(named: "icone-chat")
    var logoBtn: UIButton = .iconMenu(named: "icone-logo")
    var deslikeBtn: UIButton = .iconFooter(named: "icone-deslike")
    var likeBtn: UIButton = .iconFooter(named: "icone-like")
    var superlikeBtn: UIButton = .iconFooter(named: "icone-superlike")
    
    //MARK: - Methods
    func searchUsers() {
        UserService.shared.searchUsers { users, err in
            if let users = users {
                DispatchQueue.main.async {
                    self.users = users
                    self.addCards()
                }
            }
        }
    }
    
    //MARK: - Super Mathods
    override func viewDidLoad() {
        super.viewDidLoad()
        let loading = LoadingView(frame: view.frame)
        view.insertSubview(loading, at: 0)
        
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.systemGroupedBackground
        self.searchUsers()
        self.addCards()
        self.addFooter()
        self.addHeader()
    }
    
}


//MARK: - Footer
extension CombineVC {
    func addHeader () {
        let size: CGFloat = 32
        let svw = UIStackView(arrangedSubviews: [profileBtn, logoBtn, chatBtn])
        svw.distribution = .equalCentering
        
        view.addSubview(svw)
        view.addBoundsConstraintsTo(subView: svw, leading: 20, trailing: -20, top: nil, bottom: nil)
        view.addTopAlignmentConstraintFromSafeAreaTo(subView: svw, constant: 20)
        profileBtn.addHeightConstraint(size)
        profileBtn.addWidthConstraint(size)
        logoBtn.addHeightConstraint(size)
        logoBtn.addWidthConstraint(size)
        chatBtn.addHeightConstraint(size)
        chatBtn.addWidthConstraint(size)
        
    }
    func addFooter() {
        let size: CGFloat = 64
        let svw = UIStackView(arrangedSubviews: [UIView(),deslikeBtn,superlikeBtn,likeBtn,UIView()])
        svw.distribution = .equalCentering
        
        view.addSubview(svw)
        view.addBoundsConstraintsTo(subView: svw, leading: 20, trailing: -20, top: nil, bottom: -35)
        deslikeBtn.addTarget(self, action: #selector(deslikeClick), for: .touchUpInside)
        deslikeBtn.addWidthConstraint(size)
        deslikeBtn.addHeightConstraint(size)
        superlikeBtn.addTarget(self, action: #selector(superLikeClick), for: .touchUpInside)
        superlikeBtn.addWidthConstraint(size)
        superlikeBtn.addHeightConstraint(size)
        likeBtn.addTarget(self, action: #selector(likeClick), for: .touchUpInside)
        likeBtn.addWidthConstraint(size)
        likeBtn.addHeightConstraint(size)
        
    }
}


//MARK: - addCards
extension CombineVC {
    func addCards () {
        for user in users {
            let card: CombineCardView = {
                let vw = CombineCardView()
                vw.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
                return vw
            }()
            
            card.center = view.center
            card.user = user
            card.tag = user.id
            card.callback = {(data) in
                self.seeDetails(user: data)
            }
            
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handlerCard))
            card.addGestureRecognizer(gesture)
            
            view.insertSubview(card, at: 1)
            
        }
        
    }
    
    
    func removeCard (card: UIView){
        card.removeFromSuperview()
        self.users = self.users.filter({ (user) in
            return user.id != card.tag
        })
    }
    
    
    func matchVerification (user: User) {
        if user.match {
            let macthVC = MatchVC()
            macthVC.user = user
            macthVC.modalPresentationStyle = .fullScreen
            self.present(macthVC, animated: true, completion: nil)
        }
    }
    
    
    func seeDetails(user: User) {
        let detailVC = DetailVC()
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.user = user
        detailVC.callback =  {(user, action) in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                if action == .deslike {
                    self.deslikeClick()
                } else {
                    self.likeClick()
                }
            }
            
        }
        self.present(detailVC, animated: true, completion: nil)
    }
}
// MARK: - HandlerCards
extension CombineVC {
    
    @objc func deslikeClick() {
        self.animatedCard(rotationAngle: -0.4, action: .deslike)
    }
    
    
    @objc func likeClick() {
        self.animatedCard(rotationAngle: 0.4, action: .like)
        
    }
    
    @objc func superLikeClick(){
        self.animatedCard(rotationAngle: 0, action: .superlike)
    }
    
    @objc func handlerCard (_ gesture: UIPanGestureRecognizer) {
        if let card = gesture.view as? CombineCardView {
            let point = gesture.translation(in: view)
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            let rotationAngle = point.x / view.bounds.width * 0.4
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            if point.x > 0 {
                card.ivLike.alpha = rotationAngle * 5.0
            }else {
                card.ivDeslike.alpha = rotationAngle * 5.0 * -1
            }
            
            
            
            if gesture.state == .ended {
                
                if card.center.x > self.view.bounds.width + 45 {
                    self.animatedCard(rotationAngle: rotationAngle, action: .like)
                    return
                    
                }
                
                if card.center.x < -45 {
                    self.animatedCard(rotationAngle: rotationAngle, action: .deslike)
                    return
                }
                
                UIView.animate(withDuration: 0.3) {
                    card.center = self.view.center
                    card.transform = .identity
                    card.ivDeslike.alpha = 0.0
                    card.ivLike.alpha = 0.0
                }
            }
            
        }
    }
    
    func animatedCard(rotationAngle: CGFloat, action: Actions) {
        if let user = self.users.first {
            for view in self.view.subviews{
                if view.tag == user.id {
                    if let card = view as? CombineCardView{
                        
                        let center: CGPoint
                        var like: Bool
                        
                        switch action{
                        case .deslike:
                            center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 45)
                            like = false
                        case .like:
                            center = CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y + 45)
                            like =  true
                        case .superlike:
                            center = CGPoint(x: card.center.x, y: card.center.y - self.view.bounds.height)
                            like = true
                        }
                        UIView.animate(withDuration: 1.0) {
                            card.center = center
                            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
                            card.ivDeslike.alpha = like == false ? 1 : 0
                            card.ivLike.alpha = like == true ? 1 : 0
                        } completion: { (_)  in
                            if like {
                                self.matchVerification(user: user)
                            }
                            self.removeCard(card: card)
                        }
                        
                    }
                }
            }
        }
    }
}
