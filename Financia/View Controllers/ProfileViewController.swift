//
//  ProfileViewController.swift
//  Financia
//
//  Created by Sudikshya on 2021-03-30.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView  = UIImageView(image: UIImage(named: "tblBackground.jpg"))
    }


}
