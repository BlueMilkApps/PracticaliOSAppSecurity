//
//  EntryViewController.swift
//  Keymaster
//
//  Created by Chris Forant on 4/23/15.
//  Copyright (c) 2015 Totem. All rights reserved.
//

import UIKit
import CoreData

class EntryViewController: UIViewController {

    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var acctField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.view.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 40)
            })
        }
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.view.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 40)
            })
        }
        
        // Add blur on backgrounding
        NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationWillResignActiveNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = self.view.bounds
            self.view.addSubview(blurView)
        }
        
        // Remove blur on foregrounding
        NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationWillEnterForegroundNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            (self.view.subviews.last as? UIVisualEffectView)?.removeFromSuperview()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - Actions
extension EntryViewController {
    
    @IBAction func okTapped(sender: UIButton) {
        if saveSecret() {
            // Unwind back
            performSegueWithIdentifier("UNWIND_ENTRY", sender: self)
        }
    }
    
    @IBAction func fieldDidExit(sender: UITextField) {
    }
    
}


// MARK: - Helpers
extension EntryViewController {
    
    func saveSecret() -> Bool {
//        // Store input into Swift dictionary
//        let entryData = ["category": category,"desc": descField.text, "acct": acctField.text, "password": passwordField.text]
//        
//        // Write to file using old school dictionary (cuz Swift doesn't have this yet!)
//        let entriesPath = documentsDirectory.URLByAppendingPathComponent("Entries", isDirectory: true)
//        let filePath = entriesPath.URLByAppendingPathComponent(NSUUID().UUIDString)
//        
//        if (entryData as NSDictionary).writeToURL(filePath, atomically: true) {
//            // Add Data Protection
//            let attribs = [NSFileProtectionKey: NSFileProtectionComplete]
//            NSFileManager.defaultManager().setAttributes(attribs, ofItemAtPath: filePath.relativePath!, error: nil)
//            
//            return true
//        }else{
//            return false
//
//        }
        
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        let entity = NSEntityDescription.entityForName("Entry", inManagedObjectContext: managedObjectContext)!
        
        let entry = NSManagedObject(entity: entity, insertIntoManagedObjectContext: managedObjectContext) as! Entry
        entry.category = category
        entry.desc = descField.text
        entry.acct = acctField.text
        entry.password = passwordField.text
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
        
        return true
    }
}
