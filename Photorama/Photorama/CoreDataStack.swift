//
//  CoreDataStack.swift
//  Photorama
//
//  Created by 黄家树 on 2018/4/6.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    let managedObjectModelName:String
    private lazy var managedObjectModel:NSManagedObjectModel = {
       let modelURL = Bundle.main.url(forResource: self.managedObjectModelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    private var applicationDocumentsDirectory:URL = {
       let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.first!
    }()
    private lazy var persistentStoreCoordinator:NSPersistentStoreCoordinator = {
       var coordinatore = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let pathComponent = "\(self.managedObjectModelName).sqlite"
        let url = self.applicationDocumentsDirectory.appendingPathComponent(pathComponent)
        let store = try! coordinatore.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        return coordinatore
    }()
    lazy var mainQueueContext:NSManagedObjectContext = {
       let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.persistentStoreCoordinator = self.persistentStoreCoordinator
        moc.name = "Main Queue Context (UI Context)"
       return moc
    }()
    required init(modelName:String) {
        managedObjectModelName = modelName
    }
    func saveChanges() throws {
        var error: Error?
        mainQueueContext.performAndWait {
            do {
                try self.mainQueueContext.save()
            }catch let saveError {
                error = saveError
            }
        }
        if let error = error {
            throw error
        }
    }
    
    
}
