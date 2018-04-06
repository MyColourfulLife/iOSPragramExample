//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by 黄家树 on 2018/4/6.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var spinner:UIActivityIndicatorView!
    
    
    func updateWithImage(image:UIImage?) {
        if let imageToDisply = image {
            spinner.stopAnimating()
            imageView.image = imageToDisply
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    // 第一次创建或者重用时 重置初始状态
    // 第一次创建
    override func awakeFromNib() {
        super.awakeFromNib()
        updateWithImage(image: nil)
    }
    
    // 重用之前调用
    override func prepareForReuse() {
        super.prepareForReuse()
        updateWithImage(image: nil)
    }
    
}
