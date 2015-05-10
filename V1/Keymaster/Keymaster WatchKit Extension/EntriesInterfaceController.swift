//
//  EntriesInterfaceController.swift
//  Keymaster
//
//  Created by Chris Forant on 5/2/15.
//  Copyright (c) 2015 Totem. All rights reserved.
//

import WatchKit
import Foundation


class EntriesInterfaceController: WKInterfaceController {
    
    var category: String!
    @IBOutlet weak var table: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        category = context as! String
        if count(DataManager.sharedManager[category: category, ascending: true]) > 0 {
            table.setNumberOfRows(count(DataManager.sharedManager[category: category, ascending: true]), withRowType: "ENTRY_ROW")
            
            for i in 0...table.numberOfRows - 1 {
                if let rowController = table.rowControllerAtIndex(i) as? EntryRowController {
                    let entryName = DataManager.sharedManager[category: category, ascending: true][i]["desc"] as! String
                    rowController.entryLbl.setText(entryName)
                }
                
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        switch segueIdentifier {
        case "SEGUE_ENTRY":
            let entry = DataManager.sharedManager[category: category, ascending: true][rowIndex]
            return entry
        default: return nil
        }
    }

}
