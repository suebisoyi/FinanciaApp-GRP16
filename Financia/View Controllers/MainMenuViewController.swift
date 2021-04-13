//
//  MainMenuViewController.swift
//  Financia
//
//  Created by Gagandeep Ghotra
//

import UIKit
import Auth0

class MainMenuViewController: UIViewController {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    let credentialsManager = CredentialsManager(authentication: Auth0.authentication())//
    
    @IBOutlet weak var userProfileButton: UIButton!
    @IBAction func unwindToMainMenuViewController(sender : UIStoryboardSegue){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func userProfileButtonPressed(_ sender: UIButton) {
        guard (SessionManager.shared.credentials?.accessToken) != nil
        else {
            Auth0.webAuth().scope("openid profile offline_access email").audience("https://dev-y8kzi2o4.us.auth0.com/userinfo")
            .useEphemeralSession()
            .start {
                result in
                switch result {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                     if(!SessionManager.shared.store(credentials: credentials)) {
                            print("Failed to store credentials")
                    } else {
                        SessionManager.shared.retrieveProfile { error in
                            DispatchQueue.main.async {
                                guard error == nil else {
                                    print("Failed to retrieve profile: \(String(describing: error))")
                                    return self.userProfileButtonPressed(self.userProfileButton)
                                }
                                self.performSegue(withIdentifier: "goToUserProfile", sender: nil)
                                
                            }
                        }
                    }
                }
            }
            return
        }
        self.performSegue(withIdentifier: "goToUserProfile", sender: nil)    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
