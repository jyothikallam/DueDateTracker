//
//  ViewController.swift
//  DueDateTracker
//
//  Created by Chanikya on 9/02/2016.
//  Copyright © 2016 jyothi.demo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var category = ["Credit Cards", "Groceries", "Auto Loan", "Rent", "Utilities", "Other"]
    
    @IBOutlet weak var myTableView: UITableView!
    var data = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.hidesBackButton = true

        
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Items")
        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            data = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//      return category.count
//    }
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let cate = category[section]
//        return cate
//        
//    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let dataItem = data[indexPath.row]
        cell.textLabel!.text = dataItem.valueForKey("itemName") as? String
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if (editingStyle == UITableViewCellEditingStyle.Delete) {
       
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        // 3
        managedContext.deleteObject(data[indexPath.row])
        appDelegate.saveContext()
        
        // 4
        data.removeAtIndex(indexPath.row)
        tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("itemDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "itemDetailSegue" {
            
            if let destinationController = segue.destinationViewController as? ItemDetailViewController {
                var ns: NSIndexPath
                ns = myTableView.indexPathForSelectedRow!
                let s = data[ns.row]
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateString = dateFormatter.stringFromDate( s.valueForKey("dueDate")! as! NSDate)
                
                let array1: [String] = [s.valueForKey("itemName") as! String, s.valueForKey("category") as! String, dateString, s.valueForKey("desc") as! String, s.valueForKey("rep") as! String]
               // var array1: [String] = ["joe", "chanu"]
                
                destinationController.values = array1
                destinationController.managedObj = s
                
            }
        }
    }
  }
