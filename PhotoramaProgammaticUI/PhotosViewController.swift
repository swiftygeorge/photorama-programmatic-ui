//
//  ViewController.swift
//  PhotoramaProgammaticUI
//
//  Created by George Mapaya on 2023-02-13.
//

import UIKit
import SwiftUI

class PhotosViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    private func configureViewHierarchy() {
        self.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}

// MARK: - Previews using SwiftUI

struct PhotosVCRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = PhotosViewController
    func makeUIViewController(context: Context) -> PhotosViewController {
        return PhotosViewController()
    }
    func updateUIViewController(_ uiViewController: PhotosViewController, context: Context) {
        
    }
}

struct PhotosVCRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        PhotosVCRepresentable()
    }
}

