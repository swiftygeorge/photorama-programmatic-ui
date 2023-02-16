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
    let photoDataSource = PhotoDataSource()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PhotosCollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func loadView() {
        self.view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = photoDataSource
        self.collectionView.delegate = self
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        configureViewHierarchy()
        store.fetchInterestingPhotos { photosResult in
            switch photosResult {
            case .success(let photos):
                print("Successfully downloaded \(photos.count) photos")
                self.photoDataSource.photos = photos
            case .failure(let error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    private func configureViewHierarchy() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Photorama"
    }


}

extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        // Download the image data, which could take some time
        store.fetchImage(for: photo) { (result) -> Void in
            // The index path for the photo might have changed between the
            // time the request started and finished, so find the most
            // recent index path
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo), case .success(let image) = result else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            // When the request finishes, find the current cell for this photo
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(displaying: image)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            let photo = photoDataSource.photos[selectedIndexPath.row]
            let photoInfoVC = PhotoInfoViewController()
            photoInfoVC.photo = photo
            photoInfoVC.store = store
            navigationController?.pushViewController(photoInfoVC, animated: true)
        }
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = 2.0 * 5
        let width = (view.frame.width - padding) / 4
        return CGSize(width: width, height: width)
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

