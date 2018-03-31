//
//  PhotosViewController.swift
//  Photorama
//
//  Created by 黄家树 on 2018/3/31.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class PhotosVewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var photoStore:PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoStore.fetchRecentPhotos { (photoResult) in
            switch photoResult {
            case let .Success(photos):
                print("successfully found \(photos.count) recent photos")
                if let firstPhoto = photos.first {
                    self.photoStore.fetchImageForPohto(photo: firstPhoto, comletion: { (imageReslut) in
                        switch imageReslut {
                        case let .Success(image):
                            OperationQueue.main.addOperation {
                                self.imageView.image = image
                            }
                        case let .Failure(error):
                            print("Error download image:\(error)")
                        }
                    })
                }
            case let .Failure(error):
                print("Error fectching recent photos: \(error)")
            }
        }
    }
    
}
