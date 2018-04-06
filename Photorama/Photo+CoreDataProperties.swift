//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by 黄家树 on 2018/4/6.
//  Copyright © 2018年 huangjs. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photoID: String
    @NSManaged public var photoKey: String
    @NSManaged public var title: String
    @NSManaged public var dateTaken: NSDate
    @NSManaged public var remoteURL: URL

}
