//
//  TestLazySettingsViewController.swift
//  LazySwift
//
//  Created by killing333 on 4/5/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import LazySettings

public class TestLazySettingsViewController: UITableViewController {

	// MARK: Touch
	@IBAction func touchResetButton(sender: AnyObject) {
		LazySettings.sharedSettings.reset()
	}
	
	
	
	// MARK: Goto
	private func gotoNetworkSettings() -> Void {
		
	}
	
	
	// MARK: UITableView Data Source
	public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 2
	}
	
	public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 3
		case 1:
			return LazySettings.sharedSettings.modules.count
		default:
			return 0
		}
	}
	
	public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("cell")
		if cell == nil {
			cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
			cell!.textLabel?.font = UIFont(name: "Avenir", size: 16)
			cell!.detailTextLabel?.font = UIFont(name: "Avenir", size: 16)
		}
		
		switch indexPath.section {
		case 0:
			if let environment = LazySettingsEnvironment(rawValue: indexPath.row) {
				switch environment {
				case .Development:
					cell!.textLabel?.text = "Development"
				case .UAT:
					cell!.textLabel?.text = "UAT"
				case .Production:
					cell!.textLabel?.text = "Production"
				}
				cell!.accessoryType = ( LazySettings.sharedSettings.environment == environment ? .Checkmark : .None )
			} else {
				cell!.textLabel?.text = nil
			}
			cell!.detailTextLabel?.text = nil
		//			cell!.accessoryType = .DisclosureIndicator
		case 1:
			let module = LazySettings.sharedSettings.modules[indexPath.row]
			cell!.textLabel?.text = module.dynamicType.identifier()
			cell!.detailTextLabel?.text = nil
			cell!.accessoryType = .DisclosureIndicator
		default:
			()
		}
		
		return cell!
	}
	
	public override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}
	
	
	// MARK: UITableView Delegate
	public override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let container = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
		let label = UILabel(frame: CGRect(x: 20, y: 0, width: 320, height: 44))
		label.autoresizingMask = [ .FlexibleWidth, .FlexibleHeight ]
		label.font = UIFont(name: "Avenir-Medium", size: 18)
		container.addSubview(label)
		
		switch section {
		case 0:
			label.text = "Environment"
		case 1:
			label.text = "Modules"
		default:
			label.text = ""
		}
		
		return container
	}
	
	public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		switch indexPath.section {
		case 0:
			if let environment = LazySettingsEnvironment(rawValue: indexPath.row) {
				LazySettings.sharedSettings.environment = environment
				tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
			}
		case 1:
			let module = LazySettings.sharedSettings.modules[indexPath.row]
			switch module.dynamicType.identifier() {
			case LazySettingsGeneral.identifier():
				self.performSegueWithIdentifier("showGeneral", sender: nil)
			case LazySettingsLanguage.identifier():
				self.performSegueWithIdentifier("showLanguage", sender: nil)
			default:
				()
			}
		default:
			()
		}
	}
	

}
