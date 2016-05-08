//
//  LazySettingsGeneral.swift
//  Pods
//
//  Created by Ho Lun Wan on 4/5/2016.
//
//

import Foundation

public class LazySettingsGeneral: NSObject, LazySettingsModule {
	
	// Constant
	private let LazySettingsGeneralKeyLaunchCount: String			= "launchCount"
	private let LazySettingsGeneralKeyVersion: String				= "version"

	// Var
	public var launchCount: Int = 0
	public var becomeActiveCount: Int = 0
	public var resignActiveCount: Int = 0
	public var version: String = ""
	private var isFirstLoad: Bool = true

	public override init() {
		super.init()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LazySettingsGeneral.applicationWillEnterForegroundNotification(_:)), name: UIApplicationWillEnterForegroundNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LazySettingsGeneral.applicationWillResignActiveNotification(_:)), name: UIApplicationWillResignActiveNotification, object: nil)
		self.reset()
	}
	
	// LazySettingsModule
	
	// Unique ID for the module
	public class func identifier() -> String {
		return "LazySettings.general"
	}
	
	// Load from dictionary. Setup should be done here
	public func load(dictionary: [String : AnyObject]?) -> Void {
		launchCount = dictionary?[LazySettingsGeneralKeyLaunchCount]?.integerValue ?? launchCount
		version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String ?? version
		
		if isFirstLoad {
			launchCount += 1
			isFirstLoad = false
		}
	}
	
	// Save as a dictionary. Do whatever when it is time to save
	public func save() -> [String : AnyObject] {
		var dict: [String : AnyObject] = [:]
		
		dict[LazySettingsGeneralKeyLaunchCount] = launchCount
		dict[LazySettingsGeneralKeyVersion] = version

		return dict
	}
	
	// Reset to initial state
	public func reset() -> Void {
		if isFirstLoad {
			launchCount = 0
		} else {
			launchCount = 1
		}
		becomeActiveCount = 0
		resignActiveCount = 0
		version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown version"
	}

	/**
	Called when running environment changed
	*/
	public func environmentChanged(environment: LazySettingsEnvironment) -> Void {
		
	}
	
	// MARK: UIApplication Notifications
	func applicationWillEnterForegroundNotification(notification: NSNotification) -> Void {
		becomeActiveCount += 1
	}
	func applicationWillResignActiveNotification(notification: NSNotification) -> Void {
		resignActiveCount += 1
	}
}