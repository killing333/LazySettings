//
//  TestLazySettingsGeneralViewController.swift
//  LazySwift
//
//  Created by killing333 on 4/5/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import LazySettings

class TestLazySettingsGeneralViewController: UITableViewController {
	var generalSettings: LazySettingsGeneral!
	@IBOutlet var launchCountLabel: UILabel!
	@IBOutlet var becomeActiveCountLabel: UILabel!
	@IBOutlet var resignActiveCountLabel: UILabel!
	@IBOutlet var versionLabel: UILabel!

	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		generalSettings = LazySettings.sharedSettings.moduleForIdentifier(LazySettingsGeneral.identifier()) as! LazySettingsGeneral
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TestLazySettingsGeneralViewController.applicationDidBecomeActiveNotification(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil)
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.reload()
	}
	
	func reload() -> Void {
		launchCountLabel.text = String(format: "%ld", generalSettings.launchCount)
		becomeActiveCountLabel.text = String(format: "%ld", generalSettings.becomeActiveCount)
		resignActiveCountLabel.text = String(format: "%ld", generalSettings.resignActiveCount)
		versionLabel.text = generalSettings.version
	}
	
	
	
	// MARK: UIApplication Notifications
	func applicationDidBecomeActiveNotification(notification: NSNotification) -> Void {
		self.reload()
	}
}
