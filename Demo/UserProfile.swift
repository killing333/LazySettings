//
//  UserProfile.swift
//  Herman Miller
//
//  Created by Ho Lun Wan on 17/4/2017.
//
//

import UIKit
import LazySettings


class UserProfile: LazySettingsModule {
	var username: String?
	var email: String?
	
	
	// MARK: - LazySettingsModule
	var moduleID: String {
		return "UserProfile"
	}

	/**
	Load from dictionary. Setup should be done here
	*/
	func load(_ dictionary: [String : Any]?) -> Void {
		username = dictionary?["username"] as? String
		email = dictionary?["email"] as? String
	}

	/**
	Save as a dictionary. Do whatever when it is time to save
	*/
	func save() -> [String : Any] {
		var dict: [String : Any] = [:]
		dict["username"] = username
		dict["email"] = email

		return dict
	}

	/**
	Reset to initial state
	*/
	func reset() -> Void {
		username = ""
		email = nil
	}

	/**
	Called when running environment changed
	*/
	func environmentChanged(_ environment: LazySettingsEnvironment) -> Void {

	}
}
