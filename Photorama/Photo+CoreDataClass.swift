//
//  Photo+CoreDataClass.swift
//  Photorama
//
//  Created by 黄家树 on 2018/4/6.
//  Copyright © 2018年 huangjs. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Photo)
public class Photo: NSManagedObject {
    var image: UIImage?
    // 当对象将要加入数据库中时，会受到awakeFromInsert
    // 对photo属性进行初始化
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        title = ""
        photoID = ""
        remoteURL = NSURL() as URL
        photoKey = NSUUID().uuidString
        dateTaken = NSDate()
    }
    
    func addTagObject(tag:NSManagedObject) {
        let currentTags = mutableSetValue(forKey: "tags")
        currentTags.add(tag)
    }
    
    func removeTagObject(tag:NSManagedObject) {
        let currentTags = mutableSetValue(forKey: "tags")
        currentTags.remove(tag)
    }
    
}
