//
//  DetailViewController.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 17/12/21.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        layoutAttributes?.forEach({ (attribute) in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                guard let collectionView = collectionView else {return}
                
                let contentOfFSetY = collectionView.contentOffset.y
                attribute.frame = CGRect (x: 0, y: contentOfFSetY, width: collectionView.bounds.width, height: attribute.bounds.height - contentOfFSetY)
            }
        })
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}



class DetailVC:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    enum Actions {
        case like
        case deslike
        case superlike
    }
    
    
    //MARK: - Properties
    var user: User? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    
    let cellId = "cellId"
    let headerId = "headerId"
    let profileId = "profileId"
    let photosId = "photosId"
    //MARK: - Objects
    var callback: ((User?, Actions) -> Void)?
    
    var deslikeBtn: UIButton = .iconFooter(named: "icone-deslike")
    
    var likeBtn: UIButton = .iconFooter(named: "icone-like")
    
    var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "icone-down"), for: .normal)
        btn.backgroundColor = UIColor(red: 232/255, green: 66/255, blue: 54/255, alpha: 1)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        return btn
    }()
    
    
    //MARK: - CollectionView Methods
    //Layout
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DetailHeaderVIew
        header.user = self.user
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileId, for: indexPath) as! DetailProfileCell
            cell.user = self.user
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosId, for: indexPath) as! DetailsPhotosCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width:CGFloat = UIScreen.main.bounds.width
        var height:CGFloat = UIScreen.main.bounds.width * 0.66
        
        if indexPath.item == 0 {
        let cell = DetailProfileCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
        cell.user = self.user
        cell.layoutIfNeeded()
        
        let estimatedSize = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
        height = estimatedSize.height
        }
        return .init(width: width, height: height)

    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
        let originY = view.bounds.height*0.7-24
        
        if scrollView.contentOffset.y > 0 {
            self.backBtn.frame.origin.y = originY - scrollView.contentOffset.y
        }else{
            self.backBtn.frame.origin.y = originY + scrollView.contentOffset.y * -1
        }
    }
    
    //MARK: - Methods
    @objc func backClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deslikeClick() {
        self.callback?(self.user, Actions.deslike)
        self.backClick()
    }
    
    @objc func likeClick() {
        self.callback?(self.user, Actions.like)
        self.backClick()
    }
    
    func addBackBtn() {
        self.view.addSubview(self.backBtn)
        self.backBtn.frame = CGRect(x: view.bounds.width-69, y: view.bounds.height*0.7-24, width: 50, height: 50)
    }
    
    //MARK: - Init Methods
    func prepareElements() {
        //Collection View
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView.register(DetailHeaderVIew.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        self.collectionView.register(DetailProfileCell.self, forCellWithReuseIdentifier: profileId)
        self.collectionView.register(DetailsPhotosCell.self, forCellWithReuseIdentifier: photosId)
        self.collectionView.backgroundColor = .white
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 134, right: 0)
        
        //StackView
        let size: CGFloat = 64
        let svw = UIStackView(arrangedSubviews: [UIView(),deslikeBtn,likeBtn,UIView()])
        svw.distribution = .equalCentering
        
        self.view.addSubview(svw)
        self.view.addBoundsConstraintsTo(subView: svw, leading: 15, trailing: -15, top: nil, bottom: -35)
        self.deslikeBtn.addTarget(self, action: #selector(deslikeClick), for: .touchUpInside)
        self.deslikeBtn.addWidthConstraint(size)
        self.deslikeBtn.addHeightConstraint(size)
        self.likeBtn.addTarget(self, action: #selector(likeClick), for: .touchUpInside)
        self.likeBtn.addWidthConstraint(size)
        self.likeBtn.addHeightConstraint(size)

        //Back Button
        self.view.addSubview(self.backBtn)
        self.view.addCenterXAlignmentConstraintTo(subView: self.backBtn, constant: view.bounds.width+140)
        self.view.addCenterYAlignmentConstraintTo(subView: self.backBtn, constant: view.bounds.height*0.7+170)
        self.backBtn.addHeightConstraint(50)
        self.backBtn.addWidthConstraint(50)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareElements()
    }
    
    init() {
        super.init(collectionViewLayout: HeaderLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
