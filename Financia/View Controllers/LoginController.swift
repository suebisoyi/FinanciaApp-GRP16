//
//  LoginController.swift
//  Financia
//
//  Created by  on 4/6/21.
//

import UIKit
import Auth0

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any/Volumes/Student/FinanciaApp-GRP16-GG/Financia/Storyboards/Base.lproj/Main.storyboard additional setup after loading the view.
        
    


    Auth0.webAuth().scope("openid profile").audience("https://dev-y8kzi2o4.us.auth0.com/userinfo").start {
        result in
        switch result {
        case .failure(let error):
            // Handle the error
            print("Error: \(error)")
        case .success(let credentials):
            // Do something with credentials e.g.: save them.
            // Auth0 will automatically dismiss the login page
            print("Credentials: \(credentials)")
            
        }
        
    }
    

    /*Auth0.webAuth()
    .clearSession(federated: false) { result in
        if result {
            // Session cleared
        }
    }*/
    }
}
