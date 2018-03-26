//
//  ImageStore.swift
//  Homepwner
//
//  Created by 黄家树 on 2018/3/26.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import Foundation
import UIKit


class ImageStore {
    
    let cache = NSCache<NSString,AnyObject>()
    
    func setImage(image:UIImage, forKey key:NSString) {
        cache.setObject(image, forKey: key)
    }
    
    func imageForKey(key:NSString)-> UIImage? {
        return cache.object(forKey: key) as? UIImage
    }
    
    func deleteImageForKey(key:NSString) {
        cache.removeObject(forKey: key)
    }
}


