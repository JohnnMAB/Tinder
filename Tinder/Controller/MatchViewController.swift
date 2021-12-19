//
//  MatchViewController.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 15/12/21.
//

import UIKit

class MatchVC: UIViewController {
    
    //MARK: - Properties
    var user: User? {
        didSet {
            if let user = user {
                ivCover.image = UIImage(named: user.photo)
                lblMessage.text = "\(user.name) curtiu você também!"
            }
        }
    }
    
    
    //MARK: - Objects
    let ivCover: UIImageView = .photoImageView(named: "pessoa-1")
    
    let lblMessage: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textColor = .white
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    let ivLike: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icone-like")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let stackView: UIStackView = {
        let svw = UIStackView()
        svw.axis = .vertical
        svw.spacing = 16
        return svw
    }()
    
    let msgTextField: UITextField = {
        let txf = UITextField()
        txf.placeholder = "Diga algo legal"
        txf.backgroundColor = .lightGray
        txf.layer.cornerRadius = 8.0
        txf.textColor = .darkGray
        txf.returnKeyType = .go
        txf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        txf.leftViewMode = .always
        txf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 0))
        txf.rightViewMode = .always
        return txf
    }()
    let sendButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Enviar", for: .normal)
        btn.setTitleColor(UIColor(red: 62/255, green: 163/255, blue: 255/255, alpha: 1), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(sendMsg), for: .touchUpInside)
        return btn
    }()
    let backButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Voltar para o Tinder", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    //MARK: - Methods
    
    @objc func sendMsg(){
        if let message = self.msgTextField.text {
            print (message)
        }
    }
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: duration) {
                    self.view.frame = CGRect(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.origin.y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - keyboardSize.height)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardHide(notification: NSNotification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            self.view.frame = UIScreen.main.bounds
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.sendMsg()
        return true
    }
    
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        msgTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Gradient
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        
        // Cover
        self.view.addSubview(self.ivCover)
        self.view.addFullBoundsConstraintsTo(subView: ivCover, constant: 0)
        self.ivCover.layer.addSublayer(gradient)

        // Stack
        self.view.addSubview(self.stackView)
        self.view.addBoundsConstraintsTo(subView: self.stackView, leading: 32, trailing: -32, top: nil, bottom: -46)
        self.stackView.addArrangedSubview(self.ivLike)
        self.stackView.addArrangedSubview(self.lblMessage)
        self.stackView.addArrangedSubview(self.msgTextField)
        self.stackView.addArrangedSubview(self.backButton)
        self.ivLike.addHeightConstraint(44)
        self.msgTextField.addHeightConstraint(44)
        
        // Send Button
        self.msgTextField.addSubview(self.sendButton)
        self.msgTextField.addBoundsConstraintsTo(subView: self.sendButton, leading: nil, trailing: -16, top: 0, bottom: 0)
        
        
    }
    
}

// MARK:- Delegate
extension MatchVC: UITextFieldDelegate {
    
}
