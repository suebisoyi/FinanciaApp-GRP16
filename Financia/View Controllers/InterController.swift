//
//  InterController.swift
//  Financia
//
//  Created by Sudikshya Bisoyi

import Foundation

import UIKit

class InterController: UIViewController {
    
    public var interControllerLookedAt: Bool = false
    
    @IBAction func unwindToInterViewController(sender : UIStoryboardSegue){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interControllerLookedAt = true
        // Do any additional setup after loading the view.
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

