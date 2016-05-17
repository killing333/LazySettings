//
//  LazySettings.swift
//  Pods
//
//  Created by killing333 on 4/5/2016.
//
//

import Foundation

/**
	Environment constant
*/
@objc public enum LazySettingsEnvironment: Int {
	case Development		= 0
	case UAT				= 1
	case Production			= 2
}

/**
	Posted when environment changed
*/
public let LazySettingsEnvironmentDidChangedNotification				= "environmentDidChanged"

/**
	An organized way to save app settings to NSUserDefaults.
*/
public class LazySettings: NSObject {
	
	// Constant
	private let LazySettingsKeyInfoDict: String							= "LazySettings"
	
	// Static
	public static let sharedSettings									= LazySettings()
	public static let environmentDidChangedNotificationName				= LazySettingsEnvironmentDidChangedNotification

	// Var
	/**
		Modules added
	*/
	public var modules: [LazySettingsModule] = []
	/**
		Running environment
	*/
	public var environment: LazySettingsEnvironment = .Development {
		didSet {
			// Notify environment changes
			for module: LazySettingsModule in modules {
				module.environmentChanged(environment)
			}
			
			NSNotificationCenter.defaultCenter().postNotificationName(LazySettingsEnvironmentDidChangedNotification, object: nil)
		}
	}
	/**
		Dictionary containing all the settings of the modules
	*/
	private var info: [String : AnyObject]?
	/**
		Module name -> Module
	*/
	private var modulesHash: [String : LazySettingsModule] = [:]

	
	// Functions
	override init() {
		super.init()
	}
	
	
	// MARK: Getter
	/**
		Module of certain identifier
	*/
	public func moduleForIdentifier(ID: String) -> LazySettingsModule? {
		return modulesHash[ID]
	}
	
	
	// MARK: Helper
	/**
		Load from NSUserDefaults
	*/
	public func loadFromDisk() -> Bool {
		let userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
		
		// Get the info
		info = userDefaults.dictionaryForKey(LazySettingsKeyInfoDict) ?? [:]
		
		// Load all the module
		for module: LazySettingsModule in modules {
			module.load(info?[module.dynamicType.identifier()] as? [String : AnyObject])
		}
		
		return true
	}
	
	/**
		Save to NSUserDefaults
	*/
	public func saveToDisk() -> Bool {
		let userDefaults :NSUserDefaults = NSUserDefaults.standardUserDefaults()
		
		// Save all the module
		for module: LazySettingsModule in modules {
			info?[module.dynamicType.identifier()] = module.save()
		}
		
		userDefaults.setObject(info, forKey: LazySettingsKeyInfoDict)

		return userDefaults.synchronize()
	}
	
	/**
		Add module only if module of same identifier has not been added
	*/
	public func addModule(module: LazySettingsModule) -> Bool {
		
		if modulesHash[module.dynamicType.identifier()] == nil {
			modulesHash[module.dynamicType.identifier()] = module
			modules.append(module)
			return true
		} else {
			return false
		}
	}
	
	/**
		Reset all the settings to defaults
	*/
	public func reset() -> Bool {
		
		// Reset all the module
		for module: LazySettingsModule in modules {
			module.reset()
		}
		
		return self.saveToDisk()
	}
}