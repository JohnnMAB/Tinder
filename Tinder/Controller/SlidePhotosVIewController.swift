//
//  SlidePhotosVIewController.swift
//  Tinder
//
//  Created by Jhonathan Mattos on 17/12/21.
//

import UIKit

class SlidePhotosVC:UICollectionViewController, UICollectionViewDelegateFlowLayout {
     let cellId = "cellId"
    
    let photos: [String] = ["pessoa-1", "pessoa-2", "pessoa-3", "pessoa-4", "pessoa-5", "pessoa-6", "pessoa-7", "pessoa-8", "pessoa-9","pessoa-10"]
    
    //MARK: - CollectionView Methods
    //Layout
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SlidePhotoCell
        cell.photoImageView.image = UIImage(named: self.photos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.height / 2 - 10
        return.init(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return.init(top: 10, left: 20, bottom: 0, right: 20)
    }
    //MARK: - Init Methods
    func prepareElements() {
        self.view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareElements()
        collectionView.register(SlidePhotoCell.self, forCellWithReuseIdentifier: cellId)
    }
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
