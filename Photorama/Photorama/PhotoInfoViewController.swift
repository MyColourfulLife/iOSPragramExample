
//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by 黄家树 on 2018/4/6.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    @IBOutlet var imageView:UIImageView!
    var photo:Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store:PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchImageForPohto(photo: photo) { (reslut) in
            switch reslut {
            case let .Success(image):
                OperationQueue.main.addOperation({
                    self.imageView.image = image
                })
            case let .Failure(error):
                print("Error fetching iamge for photo:\(error)")
            }
        }
    }
    
    
    
}
