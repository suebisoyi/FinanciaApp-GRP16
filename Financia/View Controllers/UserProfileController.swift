//
//  UserProfileController.swift
//  Financia
//
//  Created by Gagandeep Ghotra 
//

import UIKit
import Auth0

class UserProfileController: UIViewController {
    
    @IBAction func unwindToUserProfileController(sender : UIStoryboardSegue){
        
    }
    let credentialsManager = CredentialsManager(authentication: Auth0.authentication())//
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var lblWelcomeUser: UILabel!
    @IBOutlet weak var ivUserImageView: UIImageView!
    
    @IBOutlet weak var lblUserFullName: UILabel!
    @IBOutlet weak var lblUserEmailAddress: UILabel!
    @IBOutlet weak var lblUserContentProgress: UILabel!
    
    @IBOutlet weak var lblUserEmailVerified: UILabel!
    var profile: UserInfo!
    
    @IBOutlet weak var btnLogOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profile = SessionManager.shared.profile
        
        self.lblWelcomeUser.text = "Welcome, \(profile.nickname ?? "no name")"
        
        guard let userImageURL = self.profile.picture else { return }
        
        let task = URLSession.shared.dataTask(with: userImageURL) { (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.ivUserImageView.image = UIImage(data: data)
            }
        }
        
        task.resume()
        
        self.lblUserFullName.text = "Name: \(profile.name!)"
        
        self.lblUserEmailAddress.text = "Email: \(profile.email!)"
        
       // var beginnerController : BeginnerController = BeginnerController(nibName: nil, bundle: nil)
        //beginnerController.beginnerControllerLookedAt
        //self.lblUserContentProgress.text = "Content Progress: \n Beginner \n \t Loans: \(BeginnerController().beginnerControllerLookedAt)"
        
        self.lblUserEmailVerified.text = "Email Verified: \(profile.emailVerified!)"
    }
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        SessionManager.shared.logout { error in
                  guard error == nil else {
                    return print("Error revoking token: \(error)")
                  }
                  
                  DispatchQueue.main.async {
                    // Session cleared
        /*let alert = UIAlertController(title: "Logged Out!", message: "You have logged out!", preferredStyle: .alert)
         let goToLoginPage = UIAlertAction(title: "Ok", style: .default, handler: {action in self.performSegue(withIdentifier: "goToLoginPage", sender: self)})
         alert.addAction(goToLoginPage)
         alert.present(self, animated: true, completion: nil)           */
                    //self.presentingViewController?.dismiss(animated: true, completion: nil)
                    //self.performSegue(withIdentifier: "goToLoginPage", sender: self)
                    SessionManager.shared.patchMode = false
                    //self.checkToken() {
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
                                                    return self.logOutButtonPressed(self.btnLogOut)
                                                }
                                                self.presentingViewController?.dismiss(animated: true, completion: nil)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                    }
                    
                  }
              }
 }

