//
//  ViewController.swift
//  Financia
//
//  Created by Gagandeep Ghotra & Sudikshya Bisoyi
//

import UIKit
import AVFoundation
import Auth0

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var volSlider: UISlider!
    
    var soundPlayer : AVAudioPlayer?
    var fadeLayer : CALayer?
    
    @IBAction func volumeDidChange(sender : UISlider)
    {
        soundPlayer?.volume = volSlider.value
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        let soundURL = Bundle.main.path(forResource: "financiaMusic", ofType: "mp3")
        let url = URL(fileURLWithPath: soundURL!)
        
        self.soundPlayer = try! AVAudioPlayer.init(contentsOf: url)
        self.soundPlayer?.currentTime = 2.0
        self.soundPlayer?.volume = self.volSlider.value
        self.soundPlayer?.numberOfLoops = -1
        self.soundPlayer?.play()
    }
    override func viewDidDisappear(_ animated: Bool) {
        soundPlayer?.stop()
    }
    
    //------------------------------------------------------------------
    // Create an instance of the credentials manager for storing credentials
    let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any/Volumes/Student/FinanciaApp-GRP16-GG/Financia/Storyboards/Base.lproj/Main.storyboard additional setup after loading the view.
        
        //-----------------------------
        
        let fadeImage = UIImage(named: "logoless.png")
        fadeLayer = CALayer.init()
        fadeLayer?.contents = fadeImage?.cgImage
        fadeLayer?.bounds = CGRect(x: 0.0, y: 0.0, width: 790.0, height: 550.0)
        fadeLayer?.position = CGPoint(x: 210, y: 220)
        self.view.layer.addSublayer(fadeLayer!)
        
        // fade animation
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        // ease fade in and out
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        // from alpha of 1.0
        fadeAnimation.fromValue = NSNumber.init(value: 1.0)
        // to alpha of 0.0 - invisible
        fadeAnimation.toValue = NSNumber.init(value: 0.0)
        fadeAnimation.isRemovedOnCompletion = false
        // 3 seconds long fade
        fadeAnimation.duration = 4.0
        fadeAnimation.beginTime = 1.0
        fadeAnimation.isAdditive = false
        // fill both forwards and backwards
        fadeAnimation.fillMode =  CAMediaTimingFillMode.both
        // repeat forever
        fadeAnimation.repeatCount=Float.infinity
        // attach animation to layer image
        fadeLayer?.add(fadeAnimation, forKey: nil)
        
        
        //-----------------------------
    }
    
    func login() {
        SessionManager.shared.patchMode = false
        self.checkToken() {
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
                                        return self.loginButtonPressed(self.loginButton)
                                    }
                                 self.performSegue(withIdentifier: "surveySegue", sender: nil)
                                }
                            }
                        }
                    }
                }
        }        
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.login()
    }
    
    // From Auth0Sample
    func checkToken(callback: @escaping () -> Void) {
        let loadingAlert = UIAlertController(title: "Loading", message: "Please, wait...", preferredStyle: .alert)
        loadingAlert.present(self, animated: true, completion: nil)
            SessionManager.shared.renewAuth { error in
                DispatchQueue.main.async {
                    loadingAlert.dismiss(animated: true) {
                        guard error == nil else {
                            print("Failed to retrieve credentials: \(String(describing: error))")
                            return callback()
                        }
                        SessionManager.shared.retrieveProfile { error in
                            DispatchQueue.main.async {
                                guard error == nil else {
                                    print("Failed to retrieve profile: \(String(describing: error))")
                                    return callback()
                                }
                                self.performSegue(withIdentifier: "surveySegue", sender: nil)
                            }
                        }
                    }
                }
            }
        }
}
