//
//  TagsViewController.swift
//  Photorama
//
//  Created by 黄家树 on 2018/4/6.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit
import CoreData

class TagsViewController: UITableViewController {
    var store:PhotoStore!
    var photo:Photo!
    var selectedIndexPaths = [NSIndexPath]()
    
    let tagDataSource = TagsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tagDataSource
        tableView.delegate = self
        updataTags()
    }
    
    func updataTags() {
        let tags = try! store.fetchMainQueueTags(predicate: nil, sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        tagDataSource.tags = tags
        
        for tag in photo.tags {
            
            if let index = tagDataSource.tags.index(of: tag) {
                let indexpath = NSIndexPath(row: index, section: 0)
                selectedIndexPaths.append(indexpath)
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = tagDataSource.tags[indexPath.row]
        if let index = selectedIndexPaths.index(of: indexPath as NSIndexPath) {
            selectedIndexPaths.remove(at: index)
            photo.removeTagObject(tag: tag)
        } else {
            selectedIndexPaths.append(indexPath as NSIndexPath)
            photo.addTagObject(tag: tag)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        do {
            try store.coreDataStack.saveChanges()
        } catch let error {
            print("Core Data save faild:\(error)")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if selectedIndexPaths.index(of: indexPath as NSIndexPath) != nil {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    @IBAction func addNewTag(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Tag", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "tag name"
            textField.autocapitalizationType = .words
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let tagName = alertController.textFields?.first!.text {
                let context = self.store.coreDataStack.mainQueueContext
                let newTag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: context)
                newTag.setValue(tagName, forKey: "name")
                do {
                    try self.store.coreDataStack.saveChanges()
                }catch let error {
                    print("Core Data save failed:\(error)")
                }
                self.updataTags()
                
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
        alertController.addAction(okAction)
        
        let cancelction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
