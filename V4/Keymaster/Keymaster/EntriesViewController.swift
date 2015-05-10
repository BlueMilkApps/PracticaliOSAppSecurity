//
//  EntriesViewController.swift
//  Keymaster
//
//  Created by Chris Forant on 4/23/15.
//  Copyright (c) 2015 Totem. All rights reserved.
//

import UIKit
import CoreData

class EntriesViewController: UITableViewController {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    
    var category: String!
    var entries = [Entry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        categoryLbl.text = category
        categoryImageView.image = UIImage(named: category)?.imageWithRenderingMode(.AlwaysTemplate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "SEGUE_ENTRY":
                let vc = segue.destinationViewController as! EntryViewController
                vc.category = category
            default: return
            }
        }
    }
    
    @IBAction func unwindFromEntryVC(segue: UIStoryboardSegue) {
        // Reload entries
        DataManager.sharedManager.loadAllEntries()
        
        // Refresh table
        tableView.reloadData()
    }

}

// MARK: - Table View Datasource
extension EntriesViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        let managedObjectModel = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectModel
        
        //let fetch = managedObjectModel.fetchRequestFromTemplateWithName("FetchByCategory", substitutionVariables: ["$CATEGORY": category])!
        
        let fetch = NSFetchRequest(entityName: "Entry")
        fetch.predicate = NSPredicate(format: "category == %@", argumentArray: [category])
        
        if let entries = managedObjectContext.executeFetchRequest(fetch, error: nil) {
            
            self.entries = entries as! [Entry]
            return count(entries)
        }else{
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let entry = entries[indexPath.row] as Entry
        
        cell.textLabel?.text = entry.desc
        cell.detailTextLabel?.text = entry.acct
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let entry = entries[indexPath.row] as Entry
        
        // Create the alert popup
        let msg = (entry.acct, entry.password)
        let alert = UIAlertController(title: entry.desc, message: "Account: \(msg.0)\nPassword: \(msg.1)", preferredStyle: UIAlertControllerStyle.Alert)
        
        // Copy button
        alert.addAction(UIAlertAction(title: "Copy Password", style: .Default, handler: { (action) -> Void in
            UIPasteboard.generalPasteboard().string = msg.1
        }))
        
        // Ok button
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (action) -> Void in
        }))
        
        // Show it
        presentViewController(alert, animated: true, completion: nil)
        
        
    }
}

// MARK: - Actions
extension EntriesViewController {
    @IBAction func addEntryTapped(sender: UIBarButtonItem) {
        showEntryInput()
    }
}

// MARK: - Helpers
extension EntriesViewController {
    func showEntryInput() {
        let alert = UIAlertController(title: "New Entry", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Description"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "ID"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Password"
        }
        
        let ok = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}


