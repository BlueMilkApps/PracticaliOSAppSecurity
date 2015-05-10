//
//  CategoriesCollectionViewController.swift
//  Keymaster
//
//  Created by Chris Forant on 4/22/15.
//  Copyright (c) 2015 Totem. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"
let highlightColor = UIColor(red:0.99, green:0.67, blue:0.16, alpha:1)

class CategoriesCollectionViewController: UICollectionViewController {
    
    let categories = ["Household" , "Finance", "Computer", "Mobile", "Email", "Shopping", "User Accounts", "Secrets", "Music", "ID", "Biometrics", "Media"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "SEGUE_ENTRIES":
                let vc = segue.destinationViewController as! EntriesViewController
                
                if let selectedIndex = (collectionView?.indexPathsForSelectedItems().last as? NSIndexPath)?.row {
                    vc.category = categories[selectedIndex]
                }
            default: return
            }
        }
    }
}

// MARK: - Collection View Datasource
extension CategoriesCollectionViewController {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count(categories)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CategoryCell
        
        // Configure the cell
        cell.categoryImageView.image = UIImage(named: categories[indexPath.row])
        cell.categoryImageView.highlightedImage = UIImage(named: categories[indexPath.row])?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader: return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! SectionHeaderView
        case UICollectionElementKindSectionFooter: return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionFooter", forIndexPath: indexPath) as! SectionFooterView
        default: return UICollectionReusableView()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = highlightColor
    }
    override func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor.clearColor()
    }
}
