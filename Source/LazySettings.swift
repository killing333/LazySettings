//
//  LazySettings.swift
//  Pods
//
//  Created by Ho Lun Wan on 4/5/2016.
//
//

import Foundation

/**
	Environment constant
*/
@objc public enum LazySettingsEnvironment: Int {
	case development		= 0
	case uat				= 1
	case production			= 2
}


/**
	Simplified way to save app settings.
	Currently support saving to NSUserDefaults
*/
open class LazySettings: NSObject {
	fileprivate let keyInfoDict											= "LazySettings"
	/**
	Singleton
	*/
	open static let shared												= LazySettings()
	/**
	Fired when environment changes
	*/
	open static let environmentDidChange								= Notification.Name("LazySettings.environmentDidChange")

	fileprivate var info: [String : Any] = [:]
	/**
		Modules added
	*/
	open private( set ) var modules: [LazySettingsModule] = []
	/**
		Running environment
	*/
	open var environment: LazySettingsEnvironment = .development {
		didSet {
			// Notify environment changes
			for module: LazySettingsModule in modules {
				module.environmentChanged(environment)
			}
			
			NotificationCenter.default.post(name: LazySettings.environmentDidChange, object: nil)
		}
	}

	

	
	// MARK: - Helper
	/**
		Load from NSUserDefaults
	*/
	open func load() -> Void {
		let userDefaults : UserDefaults = UserDefaults.standard
		
		// Get the info
		info = userDefaults.dictionary(forKey: keyInfoDict) as [String : Any]? ?? [:]
		
		// Load all the module
		for module: LazySettingsModule in modules {
			module.load(info[module.ID] as? [String : Any])
		}
	}
	
	/**
		Save to NSUserDefaults
	*/
	@discardableResult open func save() -> Bool {
		let userDefaults :UserDefaults = UserDefaults.standard
		
		// Save all the module
		for module: LazySettingsModule in modules {
			info[module.ID] = module.save()
		}
		
		userDefaults.set(info, forKey: keyInfoDict)

		return userDefaults.synchronize()
	}
	
	/**
		Add module only if module of same identifier has not been added
	*/
	@discardableResult open func add(module: LazySettingsModule) -> Bool {
		if modules.contains(where: { $0.ID == module.ID }) {
			return false
		}
		
		modules.append(module)
		return true
	}
	
	open func remove(module: LazySettingsModule) -> Bool {
		guard let idx = modules.index(where: { $0.ID == module.ID }) else {
			return false
		}
		
		modules.remove(at: idx)
		return true
	}
	
	/**
		Reset all the settings to defaults
	*/
	@discardableResult open func reset() -> Bool {
		
		// Reset all the module
		for module: LazySettingsModule in modules {
			module.reset()
		}
		
		return self.save()
	}
}
