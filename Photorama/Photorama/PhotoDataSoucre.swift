//
//  PhotoDataSoucre.swift
//  Photorama
//
//  Created by 黄家树 on 2018/4/6.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class PhotoDataSoucre: NSObject, UICollectionViewDataSource {

    var photos = [Photo]()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "UICollectionViewCell"
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.updateWithImage(image: photo.image)
        return cell
    }
    
    
}
