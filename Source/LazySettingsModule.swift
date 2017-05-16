//
//  LazySettingsModuleProtocol.swift
//  Pods
//
//  Created by Ho Lun Wan on 4/5/2016.
//
//

import Foundation

@objc public protocol LazySettingsModule {
	
	/**
	Unique ID for the module
	*/
	var moduleID: String { get }
	
	/**
	Load from dictionary. Setup should be done here
	*/
	func load(_ dictionary: [String : Any]?) -> Void
	
	/**
	Save as a dictionary. Do whatever when it is time to save
	*/
	func save() -> [String : Any]
	
	/**
	Reset to initial state
	*/
	func reset() -> Void
	
	/**
	Called when running environment changed
	*/
	func environmentChanged(_ environment: LazySettingsEnvironment) -> Void
}
