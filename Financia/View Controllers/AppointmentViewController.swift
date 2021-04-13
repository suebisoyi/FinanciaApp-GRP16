//
//  AppointmentViewController.swift
//  Financia
//
//  Created by Harman Bath on 2021-04-10.
//

import UIKit
import MessageUI

class CellClass: UITableViewCell{
    
}

class AppointmentViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [String]()
    
    @IBOutlet weak var btnSelectFinTopic: UIButton!
    
    @IBOutlet weak var btnSelectContactMethod: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.preferredDatePickerStyle = .compact
    

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func appointmentConfirmationAlert(_ sender: Any) {
        appointmentConfirmAlert()
    }
    

    func addTransparentView(frame: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height, width: frame.width, height: 0)
        
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height + 5, width: frame.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func onClickSelectTopic(_ sender: Any) {
        dataSource = ["Payment Options", "Borrowing/Loans", "Investments", "Protection", "Other"]
        selectedButton = btnSelectFinTopic
        addTransparentView(frame: btnSelectFinTopic.frame)
        
    }

    @IBAction func onClickSelectContactMethod(_ sender: Any) {
        dataSource = ["Email", "Home Phone", "Mobile Phone"]
        selectedButton = btnSelectContactMethod
        addTransparentView(frame: btnSelectContactMethod.frame)
    }
}

extension AppointmentViewController: UITableViewDelegate, UITableViewDataSource{func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = dataSource[indexPath.row]
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
    removeTransparentView()
}

func appointmentConfirmAlert(){
    let alertController = UIAlertController(title: "Success!", message: "An advisor will be in contact with you shortly. Please check your email shortly.", preferredStyle: .alert)
    let alertaction = UIAlertAction(title: "Confirm", style: .cancel, handler: nil)
    alertController.addAction(alertaction)
    self.present(alertController, animated: true, completion: nil)
}
    
}
