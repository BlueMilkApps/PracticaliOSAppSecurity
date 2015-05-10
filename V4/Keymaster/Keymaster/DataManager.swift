//
//  DataManager.swift
//  Keymaster
//
//  Created by Chris Forant on 4/25/15.
//  Copyright (c) 2015 Totem. All rights reserved.
//

import Foundation

let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last as! NSURL
let entriesPath = documentsDirectory.URLByAppendingPathComponent("Entries", isDirectory: true)

// Singleton
class DataManager: NSObject {
    static let sharedManager = DataManager()
    
    var entries = [[String: AnyObject]]()
    
    override init() {
        super.init()
        
        loadAllEntries()
    }
}


// MARK: - Subscript
extension DataManager {
    subscript(#category: String, #ascending: Bool) -> [[String: AnyObject]] {
        // Filter
        let filteredEntries = entries.filter({ (entry) -> Bool in
            return (entry["category"] as! String == category) ? true : false
        })
        
        // Sort
        let sortedEntries: [[String: AnyObject]]
        switch ascending {
        case true:
            sortedEntries = filteredEntries.sorted({ (entryA, entryB) -> Bool in
                if (entryA["desc"] as! String).localizedCaseInsensitiveCompare(entryB["desc"] as! String) == NSComparisonResult.OrderedAscending {
                    return true
                }else{
                    return false
                }
            })
        case false:
            sortedEntries = filteredEntries.sorted({ (entryA, entryB) -> Bool in
                if (entryA["desc"] as! String).localizedCaseInsensitiveCompare(entryB["desc"] as! String) == NSComparisonResult.OrderedDescending {
                    return true
                }else{
                    return false
                }
            })
        default: return filteredEntries
        }
        
        return sortedEntries
    }
}


// MARK: - Helpers
extension DataManager {
    func loadEntryFromFile(url: NSURL) -> [String: AnyObject]? {
        return NSDictionary(contentsOfURL: url) as? [String: AnyObject]
    }
    
    func loadAllEntries() {
        // Reset entries
        entries = [[String: AnyObject]]()

        // Load entries from file
        if let urls = NSFileManager.defaultManager().contentsOfDirectoryAtURL(entriesPath, includingPropertiesForKeys: nil, options: nil, error: nil) as? [NSURL] {
            for url in urls {
                if let entry = loadEntryFromFile(url) {
                    entries.append(entry)
                }
            }
        }
        
    }
}