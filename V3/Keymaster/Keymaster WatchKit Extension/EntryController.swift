//
//  EntryController.swift
//  Keymaster
//
//  Created by Chris Forant on 5/3/15.
//  Copyright (c) 2015 Totem. All rights reserved.
//

import WatchKit
import Foundation


class EntryController: WKInterfaceController {
    @IBOutlet weak var descLbl: WKInterfaceLabel!
    @IBOutlet weak var acctLbl: WKInterfaceLabel!
    @IBOutlet weak var passwordLbl: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let entry = context as! [String: String]
        
        descLbl.setText(entry["desc"])
        acctLbl.setText("acct: " + entry["acct"]!)
        passwordLbl.setText("pass: " + entry["password"]!)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func dismissTapped() {
        dismissController()
    }
}
