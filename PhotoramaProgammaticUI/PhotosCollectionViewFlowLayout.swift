//
//  PhotosCollectionViewFlowLayout.swift
//  PhotoramaProgammaticUI
//
//  Created by George Mapaya on 2023-02-16.
//

import UIKit

class PhotosCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        scrollDirection = .vertical
        estimatedItemSize = .zero
        itemSize = CGSize(width: 90, height: 90)
        minimumLineSpacing = 2
        minimumInteritemSpacing = 2
        sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    
}
