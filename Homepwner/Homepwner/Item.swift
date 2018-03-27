//
//  Item.swift
//  Homepwner
//
//  Created by 黄家树 on 2018/3/21.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import Foundation

class Item: NSObject,NSCoding {
    var name: String
    var valueInDollars:Int
    var serialNumber:String?
    let dateCreated:NSDate
    let itemKey:NSString
    
    init(name:String,valueInDollars:Int,serialNumber:String?) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().uuidString as NSString
        super.init()
    }
    
    convenience init(random:Bool = false) {
        if random {
            
            let adjectives = ["Fluffy","Rusty","Shiny"]
            let nouns = ["bear","Spork","Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNouns = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNouns)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerilNumber = NSUUID().uuidString.components(separatedBy: "-").first
            
            self.init(name: randomName, valueInDollars: randomValue, serialNumber: randomSerilNumber)
        } else {
            self.init(name: "", valueInDollars: 0, serialNumber: nil)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(itemKey, forKey: "itemKey")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name =  aDecoder.decodeObject(forKey: "name") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! NSDate
        itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String as NSString
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as! String?
        valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
        super.init()
    }
    
}
