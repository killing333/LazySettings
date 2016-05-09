//
//  TestLazySettingsViewController.swift
//  LazySwift
//
//  Created by Ho Lun Wan on 4/5/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import LazySettings

class TestLazySettingsViewController: UITableViewController {

	// MARK: Touch
	@IBAction func touchResetButton(sender: AnyObject) {
		LazySettings.sharedSettings.reset()
	}
	
	
	
	// MARK: UITableView Data Source
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return LazySettings.sharedSettings.modules.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
		let module: LazySettingsModule = LazySettings.sharedSettings.modules[indexPath.row]
		
		cell.textLabel!.text = module.dynamicType.identifier()
		
		return cell
	}
	
	// MARK: UITableView Delegate
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let module: LazySettingsModule = LazySettings.sharedSettings.modules[indexPath.row]

		switch module.dynamicType.identifier() {
		case LazySettingsGeneral.identifier():
			self.performSegueWithIdentifier("showGeneral", sender: nil)
		case LazySettingsLanguage.identifier():
			self.performSegueWithIdentifier("showLanguage", sender: nil)
		default: ()
		}
	}
}
