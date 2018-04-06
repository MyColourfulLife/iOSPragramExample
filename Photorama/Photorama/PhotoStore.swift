//
//  PhotoStore.swift
//  Photorama
//
//  Created by 黄家树 on 2018/3/31.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(Error)
}

enum PhotoError:Error {
    case ImageCreateError
}

class PhotoStore {
    let session : URLSession = {
       let config = URLSessionConfiguration.default
       return URLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(completion:@escaping (PhotosResult)->Void){
        let url = FlickrAPI.recentPhotosURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
           let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processRecentPhotosRequest(data:Data? , error:Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return FlickrAPI.photosFromJSONData(data: jsonData)
    }
    
    func fetchImageForPohto(photo:Photo,comletion:@escaping (ImageResult)->Void) {
        if let image = photo.image {
            comletion(.Success(image))
            return
        }
        let photoURl = photo.remoteURL
        let request = URLRequest(url: photoURl)
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processImageRequest(data: data, error: error)
            if case let .Success(image) = result {
                photo.image = image
            }
            comletion(result)
        }
        task.resume()
    }
    
    func processImageRequest(data:Data?,error:Error?) -> ImageResult {
        guard let imageData = data, let image = UIImage.init(data: imageData) else {
            if data == nil {
                return .Failure(error!)
            } else {
                return .Failure(PhotoError.ImageCreateError)
            }
        }
        return .Success(image)
    }
    
    
}
