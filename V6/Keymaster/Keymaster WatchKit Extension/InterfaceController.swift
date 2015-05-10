//
//  InterfaceController.swift
//  Keymaster WatchKit Extension
//
//  Created by Chris Forant on 5/2/15.
//  Copyright (c) 2015 Totem. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    let categories = ["Household" , "Finance", "Computer", "Mobile", "Email", "Shopping", "User Accounts", "Secrets", "Music", "ID", "Biometrics", "Media"]

    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        println("App Group Path: \(sharedContainerPath)")
        
        // Init categories table
        table.setNumberOfRows(count(categories), withRowType: "CATEGORY_ROW")
        
        for i in 0...table.numberOfRows - 1 {
            if let rowController = table.rowControllerAtIndex(i) as? CategoryRowController {
                rowController.categoryLbl.setText(categories[i])
                rowController.categoryImage.setImageNamed(categories[i])
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
        case "SEGUE_ENTRIES":
            return categories[rowIndex] ?? nil
        default: return nil
        }
    }
}
