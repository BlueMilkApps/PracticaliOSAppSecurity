//
//  EntryViewController.swift
//  Keymaster
//
//  Created by Chris Forant on 4/23/15.
//  Copyright (c) 2015 Totem. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var acctField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        // Store input into Swift dictionary
        let entryData = ["category": category,"desc": descField.text, "acct": acctField.text, "password": passwordField.text]
        
        // Write to file using old school dictionary (cuz Swift doesn't have this yet!)
        let filePath = sharedEntriesPath.URLByAppendingPathComponent(NSUUID().UUIDString)
        
        return (entryData as NSDictionary).writeToURL(filePath, atomically: true)
    }
}
