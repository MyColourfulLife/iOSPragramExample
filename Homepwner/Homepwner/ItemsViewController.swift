//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by 黄家树 on 2018/3/21.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemsStore:ItemStore!
    var imageStore:ImageStore!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    @IBAction func addNewItem(sender:AnyObject) {
        
        let item = itemsStore.createItem()
        if let index = itemsStore.allItems.index(of: item) {
            let indexPath = NSIndexPath(row: index, section: 0);
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.updateLables()
        let item = itemsStore.allItems[indexPath.row]
        cell.nameLable.text = item.name
        cell.valueLabel.text = "$\(item.valueInDollars)"
        cell.serialNumberLabel.text = item.serialNumber
        cell.updateColor()
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemsStore.allItems[indexPath.row]
            let ac = UIAlertController(title: "Delete \(item.name) ?", message: "Are you sure you want to delete this item", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.itemsStore.removeItem(item: item)
                self.imageStore.deleteImageForKey(key: item.itemKey)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemsStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
            let item = itemsStore.allItems[row]
                let detailViweController = segue.destination as! DetailViewController
                detailViweController.item = item
                detailViweController.imageStore = imageStore
            }
        }
    }
    
}
