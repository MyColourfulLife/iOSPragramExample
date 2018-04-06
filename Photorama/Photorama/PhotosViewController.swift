//
//  PhotosViewController.swift
//  Photorama
//
//  Created by 黄家树 on 2018/3/31.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class PhotosVewController: UIViewController,UICollectionViewDelegate {
    
    @IBOutlet var collectionView:UICollectionView!
    
    var photoStore:PhotoStore!
    let photoDataSoucrce = PhotoDataSoucre()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSoucrce
        collectionView.delegate = self
        
        photoStore.fetchRecentPhotos { (photosResult) in
            OperationQueue.main.addOperation {
                switch photosResult {
                    
                case let  .Success(photos):
                    print("Successful found \(photos.count) recent photos")
                    self.photoDataSoucrce.photos = photos
                case let  .Failure(error):
                    self.photoDataSoucrce.photos.removeAll()
                    print("Error fetching recent photos :\(error)")
                }
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let photo = photoDataSoucrce.photos[indexPath.row]
        // Download the image data ,which could make some time
        photoStore.fetchImageForPohto(photo: photo) { (result) in
            OperationQueue.main.addOperation({
                // 请请求开始和结束之间，图片的下标可能会发生改变，因此找到最新的下标
                let photos = self.photoDataSoucrce.photos as NSArray
                let photoIndex = photos.index(of: photo)
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                // 请求完成之后，只更新这个cell，如果这个cell仍然可见
                if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                }
            })
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhoto" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSoucrce.photos[selectedIndexPath.row]
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = photoStore
            }
        }
    }
    
}

