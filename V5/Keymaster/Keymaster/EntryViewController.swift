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
        let entryData = ["category": category,"desc": descField.text, "acct": acctField.text]
        
        // Save to keychain
        let keychain = Keychain(serviceName: "com.totem.keymaster", accessMode: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, group: nil)
        let passwordKey = GenericKey(keyName: "\(category)+\(descField.text)", value: passwordField.text)
        
        keychain.add(passwordKey)
        
        // Write category and description info only to file using old school dictionary (cuz Swift doesn't have this yet!)
        let entriesPath = documentsDirectory.URLByAppendingPathComponent("Entries", isDirectory: true)
        let filePath = entriesPath.URLByAppendingPathComponent(NSUUID().UUIDString)
        
        return (entryData as NSDictionary).writeToURL(filePath, atomically: true)
    }
}
