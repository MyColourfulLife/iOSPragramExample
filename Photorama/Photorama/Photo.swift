//
//  Photo.swift
//  Photorama
//
//  Created by 黄家树 on 2018/3/31.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class Photo {
    let title:String
    let remoteURL:URL
    let photoID:String
    let dateTaken:Date
    var image:UIImage?
    
    init(title:String,photoID:String,remoteURL:URL,dateTaken:Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}
