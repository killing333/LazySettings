//
//  TestLazySettingsLanguageViewController.swift
//  LazySettings
//
//  Created by killing333 on 9/5/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import LazySettings

class TestLazySettingsLanguageViewController: UITableViewController {
	@IBOutlet var languageLabel: UILabel!
	
	// Var
	var localizations: [String]!
	var languageSettings: LazySettingsLanguage?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		print(NSBundle.mainBundle().localizations)
		print(NSBundle.mainBundle().preferredLocalizations)
		languageSettings = LazySettings.sharedSettings.moduleForIdentifier(LazySettingsLanguage.identifier()) as? LazySettingsLanguage
		reload()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		reloadText()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	
	
	// MARK: Helper
	func reload() -> Bool {
		localizations = NSBundle.mainBundle().localizations
		return true
	}
	func reloadText() -> Bool {
		languageLabel.text = languageSettings?.localizedStringForKey("test-string-language", value: "test-string-language", table: nil)
		navigationItem.title = LLocStr("test-string")
		return true
	}
	
	
	
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return localizations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
		cell.textLabel?.text = localizations[indexPath.row]
		cell.detailTextLabel?.text = nil
		cell.accessoryType = ( languageSettings?.currentLanguage == localizations[indexPath.row] ? .Checkmark : .None )

        return cell
    }

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		languageSettings?.currentLanguage = localizations[indexPath.row]
		tableView.reloadSections(NSIndexSet.init(index: 0), withRowAnimation: .Automatic)
		reloadText()
	}
	
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
