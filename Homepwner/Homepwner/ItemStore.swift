//
//  ItemStore.swift
//  Homepwner
//
//  Created by 黄家树 on 2018/3/21.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import Foundation

class ItemStore {
    var allItems = [Item]()
    let itemArchiveURL:URL = {
       let documentDirectiories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectiorie = documentDirectiories.first!
        return documentDirectiorie.appendingPathComponent("items.archive")
    }()
    
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems += archivedItems
        }
    }
    
    func createItem() -> Item {
        let newItem = Item(random:true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item:Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex:Int , toIndex: Int) {
        if toIndex == fromIndex {
            return
        }
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
    func saveChanges()->Bool {
        print("Saving items to \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
}
