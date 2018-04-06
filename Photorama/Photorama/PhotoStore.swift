//
//  PhotoStore.swift
//  Photorama
//
//  Created by 黄家树 on 2018/3/31.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit
import CoreData

enum ImageResult {
    case Success(UIImage)
    case Failure(Error)
}

enum PhotoError:Error {
    case ImageCreateError
}

class PhotoStore {
    let coreDataStack = CoreDataStack(modelName: "Photorama")
    let imageStore = ImageStore()
    let session : URLSession = {
       let config = URLSessionConfiguration.default
       return URLSession(configuration: config)
    }()
    
    
    func fetchRecentPhotos(completion:@escaping (PhotosResult)->Void){
        let url = FlickrAPI.recentPhotosURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
           var result = self.processRecentPhotosRequest(data: data, error: error)
            if case let .Success(photos) = result {
                let mainQueueContext = self.coreDataStack.privateQueueContext
                mainQueueContext.performAndWait {
                    try! mainQueueContext.obtainPermanentIDs(for: photos)
                }
                let objectIDs = photos.map({
                    photo in
                    return photo.objectID
                })
                let predicate = NSPredicate(format: "self IN %@", objectIDs)
                let sortByDateTaken = NSSortDescriptor(key: "dateTaken", ascending: true)
                do {
                    try self.coreDataStack.saveChanges()
                    let mainQueuePhotos = try self.fetchMainQueuePhotos(predicate: predicate, sortDescriptors: [sortByDateTaken])
                    result = .Success(mainQueuePhotos)
                }catch let error {
                    result = .Failure(error)
                }
            }
            completion(result)
        }
        task.resume()
    }
    
    func processRecentPhotosRequest(data:Data? , error:Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return FlickrAPI.photosFromJSONData(data: jsonData , inContext: self.coreDataStack.privateQueueContext)
    }
    
    func fetchImageForPohto(photo:Photo,comletion:@escaping (ImageResult)->Void) {
        if let image = imageStore.imageForKey(key: photo.photoKey as NSString) {
            comletion(.Success(image))
            return
        }
        let photoURl = photo.remoteURL
        let request = URLRequest(url: photoURl)
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processImageRequest(data: data, error: error)
            if case let .Success(image) = result {
                photo.image = image
                self.imageStore.setImage(image: image, forKey: photo.photoKey as NSString)
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
    
    func fetchMainQueuePhotos(predicate:NSPredicate? = nil, sortDescriptors:[NSSortDescriptor]? = nil)throws -> [Photo] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        let mainQueueContext = self.coreDataStack.mainQueueContext
        var mainQueuePhotos:[Photo]?
        var fetchRequestError:Error?
        mainQueueContext.performAndWait {
            do{
                mainQueuePhotos = try mainQueueContext.fetch(fetchRequest) as? [Photo]
            }catch let error {
                fetchRequestError = error
            }
        }
        guard let photos = mainQueuePhotos else {
            throw fetchRequestError!
        }
        return photos
    }
    
    func fetchMainQueueTags(predicate: NSPredicate? = nil, sortDescriptors:[NSSortDescriptor]?=nil)throws -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tag")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        let mainQueueContext = self.coreDataStack.mainQueueContext
        var mainQueueTags: [NSManagedObject]?
        var fetchRequestError:Error?
        mainQueueContext.performAndWait {
            do {
                mainQueueTags = try mainQueueContext.fetch(fetchRequest)
            }catch let error {
                fetchRequestError = error
            }
        }
        guard let tags = mainQueueTags else {
            throw fetchRequestError!
        }
        
        return tags
    }
    
    
    
    
}
