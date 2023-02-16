//
//  PhotoInfoViewController.swift
//  PhotoramaProgammaticUI
//
//  Created by George Mapaya on 2023-02-16.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewHierarchy()
        store.fetchImage(for: photo) { (result) -> Void in
            switch result {
            case .success(let image):
                self.imageView.image = image
            case .failure(let error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
    private func configureViewHierarchy() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(imageView)
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: margins.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    

}
