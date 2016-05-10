//
//  LazySettingsLanguage.swift
//  Pods
//
//  Created by Ho Lun Wan on 8/5/2016.
//
//

import UIKit


public func LLocStr(_ key: String) -> String {
	if let languageSettings = LazySettings.sharedSettings.moduleForIdentifier(LazySettingsLanguage.identifier()) as? LazySettingsLanguage {
		return languageSettings.localizedStringForKey(key, value: key, table: nil)
	} else {
		return key
	}
}

public class LazySettingsLanguage: NSObject, LazySettingsModule {
	
	// Constant
	private let LazySettingsLanguageKeyCurrentLanguage				= "currentLanguage"

	// Var
	/**
	Current language used
	nil means use device's default
	*/
	public var currentLanguage: String? {
		willSet {
			if let language = newValue where NSBundle.mainBundle().localizations.contains(language),
			   let path = NSBundle.mainBundle().pathForResource(language, ofType: "lproj") {
				currentLanguage = newValue
				currentLocalizationBundle = NSBundle(path: path)
			} else {
				currentLanguage = nil
				currentLocalizationBundle = NSBundle.mainBundle()
			}
			print(currentLanguage)
			print(currentLocalizationBundle)
		}
	}
	private var currentLocalizationBundle: NSBundle?
	
	public override init() {
		super.init()
		reset()
	}
	
	
	// Functions
	public func localizedStringForKey(_ key: String, value value: String?, table tableName: String?) -> String {
		if let locStr = currentLocalizationBundle?.localizedStringForKey(key, value: value, table: tableName) {
			return locStr
		} else {
			return key
		}
	}
	
	// LazySettingsModule
	
	// Unique ID for the module
	public class func identifier() -> String {
		return "LazySettings.language"
	}
	
	// Load from dictionary. Setup should be done here
	public func load(dictionary: [String : AnyObject]?) -> Void {
		currentLanguage = dictionary?[LazySettingsLanguageKeyCurrentLanguage] as? String
	}
	
	// Save as a dictionary. Do whatever when it is time to save
	public func save() -> [String : AnyObject] {
		var dict: [String : AnyObject] = [:]
		
		dict[LazySettingsLanguageKeyCurrentLanguage] = currentLanguage
		
		return dict
	}
	
	// Reset to initial state
	public func reset() -> Void {
		currentLanguage = nil
	}
	
	/**
	Called when running environment changed
	*/
	public func environmentChanged(environment: LazySettingsEnvironment) -> Void {
		
	}

}
