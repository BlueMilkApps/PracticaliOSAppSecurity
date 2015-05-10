//
//  Entry.swift
//  Keymaster
//
//  Created by Chris Forant on 4/26/15.
//  Copyright (c) 2015 Totem. All rights reserved.
//

import Foundation
import CoreData

class Entry: NSManagedObject {

    @NSManaged var acct: String
    @NSManaged var desc: String
    @NSManaged var category: String
    @NSManaged var password: String

}
