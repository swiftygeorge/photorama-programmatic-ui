//
//  Photo.swift
//  PhotoramaProgammaticUI
//
//  Created by George Mapaya on 2023-02-14.
//

import Foundation

struct Photo: Codable, Equatable {
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        lhs.photoID == rhs.photoID
    }
    
    let title: String
    let remoteURL: URL?
    let photoID: String
    let dateTaken: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }
}

struct FlickrResponse: Codable {
    let photosInfo: FlickrPhotosResponse
    
    enum CodingKeys: String, CodingKey{
        case photosInfo = "photos"
    }
}

struct FlickrPhotosResponse: Codable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}

