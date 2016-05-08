//
//  LazySettingsModuleProtocol.swift
//  Pods
//
//  Created by Ho Lun Wan on 4/5/2016.
//
//

import Foundation

public protocol LazySettingsModule {
	
	/**
	Unique ID for the module
	*/
	static func identifier() -> String
	
	/**
	Load from dictionary. Setup should be done here
	*/
	func load(dictionary: [String : AnyObject]?) -> Void
	
	/**
	Save as a dictionary. Do whatever when it is time to save
	*/
	func save() -> [String : AnyObject]
	
	/**
	Reset to initial state
	*/
	func reset() -> Void
	
	/**
	Called when running environment changed
	*/
	func environmentChanged(environment: LazySettingsEnvironment) -> Void
}