//
//  LazySettingsLanguage.swift
//  Pods
//
//  Created by Ho Lun Wan on 8/5/2016.
//
//

import UIKit

public class LazySettingsLanguage: NSObject, LazySettingsModule {
//	var currentLanguage
	
	// Functions
	
	// LazySettingsModule
	
	// Unique ID for the module
	public class func identifier() -> String {
		return "LazySettings.language"
	}
	
	// Load from dictionary. Setup should be done here
	public func load(dictionary: [String : AnyObject]?) -> Void {
	}
	
	// Save as a dictionary. Do whatever when it is time to save
	public func save() -> [String : AnyObject] {
		var dict: [String : AnyObject] = [:]
		
		
		return dict
	}
	
	// Reset to initial state
	public func reset() -> Void {
	}
	
	/**
	Called when running environment changed
	*/
	public func environmentChanged(environment: LazySettingsEnvironment) -> Void {
		
	}

}
