//
//  UIViewController.swift
//  Financia
//
//  Created by  on 4/9/21.
//

import Foundation
import UIKit

extension UIViewController {
    //Create a standard alert message
    
    func showError(_title : String?, message: String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(ok)
        present(controller, animated: true, completion: nil)
    }
}
