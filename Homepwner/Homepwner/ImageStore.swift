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
        let imageURL = imageURLForKey(key: key as String)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            do{
                try  data.write(to: imageURL, options: .atomic)
            }
            catch {
                print("write to file error: \(error)")
            }
        }
    }
    
    func imageForKey(key:NSString)-> UIImage? {
        
        if let exsitiingImage = cache.object(forKey: key) as? UIImage {
            return exsitiingImage
        }
        
        let imageURL = imageURLForKey(key: key as String)
        
        guard let imageFormDisk = UIImage(contentsOfFile: imageURL.path) else {
            return nil
        }
        
        return imageFormDisk
    }
    
    func deleteImageForKey(key:NSString) {
        cache.removeObject(forKey: key)
        do {
            try FileManager.default.removeItem(at: imageURLForKey(key: key as String))

        } catch let deleteError {
            print("Error remoing the image from disk :\(deleteError)")
        }
    }
    
    func imageURLForKey(key:String) -> URL {
        let documentsDirectiories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
        let documentsDirectiorie = documentsDirectiories.first!
        return documentsDirectiorie.appendingPathComponent(key)
    }
}


