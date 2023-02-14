//
//  ViewController.swift
//  PhotoramaProgammaticUI
//
//  Created by George Mapaya on 2023-02-13.
//

import UIKit
import SwiftUI

class PhotosViewController: UIViewController {
    
    var store: PhotoStore!
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewHierarchy()
        store.fetchInterestingPhotos { photosResult in
            switch photosResult {
            case .success(let photos):
                print("Successfully downloaded \(photos.count) photos")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case .failure(let error):
                print("Error fetching interesting photos: \(error)")
            }
        }
    }
    
    private func configureViewHierarchy() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Photorama"
        self.view.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateImageView(for photo: Photo) {
        self.store.fetchPhoto(for: photo) { imageResult in
            switch imageResult {
            case .success(let image):
                self.photoImageView.image = image
            case .failure(let error):
                print("Error downloading image: \(error)")
            }
        }
    }


}

// MARK: - Previews using SwiftUI

struct PhotosVCRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = PhotosViewController
    func makeUIViewController(context: Context) -> PhotosViewController {
        let photosViewController = PhotosViewController()
        photosViewController.store = PhotoStore()
        photosViewController.navigationItem.title = "Photorama"
        return photosViewController
    }
    func updateUIViewController(_ uiViewController: PhotosViewController, context: Context) {
        
    }
}

struct PhotosVCRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PhotosVCRepresentable()
        }
    }
}

