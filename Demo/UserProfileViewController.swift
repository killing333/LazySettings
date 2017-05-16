//
//  UserProfileViewController.swift
//  LazySettings
//
//  Created by Ho Lun Wan on 16/5/2017.
//
//

import UIKit
import LazySettings

class UserProfileViewController: UIViewController {
	@IBOutlet var usernameTextField: UITextField?
	@IBOutlet var emailTextField: UITextField?
	
	var profile: UserProfile? {
		didSet {
			updateUIForProfile()
		}
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		updateUIForProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func willMove(toParentViewController parent: UIViewController?) {
		super.willMove(toParentViewController: parent)
		
		if parent == nil {
			profile?.username = usernameTextField?.text
			profile?.email = emailTextField?.text
			LazySettings.shared.save()
		}
	}
	
	
	
	
	
	// MARK: - Helper
	func updateUIForProfile() -> Void {
		usernameTextField?.text = profile?.username
		emailTextField?.text = profile?.email
	}
	
	
	
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
