//
//  AppointmentViewController.swift
//  Financia
//
//  Created by Harman Bath 
//

import UIKit
import MessageUI
import PhoneNumberKit

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
    
    @IBOutlet weak var textFieldPhoneNumber: PhoneNumberTextField!
    
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
    
    if dataSource[indexPath.row].description == "Home Phone" ||
        dataSource[indexPath.row].description == "Mobile Phone" {
        textFieldPhoneNumber.isEnabled = true
        
        textFieldPhoneNumber.withExamplePlaceholder = true
        textFieldPhoneNumber.defaultRegion = "CA"
        textFieldPhoneNumber.withFlag = true
        textFieldPhoneNumber.withDefaultPickerUI = true
        textFieldPhoneNumber.withPrefix = true
        textFieldPhoneNumber.maxDigits = 15
    }
    
    if dataSource[indexPath.row].description == "Email" {
        textFieldPhoneNumber.isEnabled = false
        textFieldPhoneNumber.withExamplePlaceholder = false
       
        textFieldPhoneNumber.withFlag = false
        textFieldPhoneNumber.withDefaultPickerUI = false
        textFieldPhoneNumber.withPrefix = false
    }
}

func appointmentConfirmAlert(){
    let phoneNumberKit = PhoneNumberKit()
    let dateFormatter = DateFormatter()
    //dateFormatter.dateFormat = "HH:mm E, d MMM y"
    dateFormatter.dateStyle = .full
    dateFormatter.timeStyle = .short
    
    if selectedButton.titleLabel?.text == "Email" {
        let alertController = UIAlertController(title: "Success!", message: "An advisor will be in contact with you shortly.\n Please remember to check your email shortly.\n The meeting is scheduled to be on \(dateFormatter.string(from: datePicker.date)) and will be about \(String(describing: btnSelectFinTopic.titleLabel!.text!))", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "Confirm", style: .cancel, handler: {action in  self.presentingViewController?.dismiss(animated: true, completion: nil)})
        alertController.addAction(alertaction)
        self.present(alertController, animated: true, completion: nil)
    }
    if selectedButton.titleLabel?.text == "Home Phone" ||
        selectedButton.titleLabel?.text == "Mobile Phone" {
        do {
        let phoneNumber = try phoneNumberKit.parse(textFieldPhoneNumber?.text ?? "")
    
        
        if selectedButton.titleLabel?.text == "Home Phone" {
            let alertController = UIAlertController(title: "Success!", message: "An advisor will be in touch with you shortly. Please remember that the advisor will call your home phone:\n \(phoneNumberKit.format(phoneNumber, toType: .international)).\n The meeting is scheduled to be on \(dateFormatter.string(from: datePicker.date)) and will be about \(String(describing: btnSelectFinTopic.titleLabel!.text!)) \n", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "Confirm", style: .cancel, handler: {action in  self.presentingViewController?.dismiss(animated: true, completion: nil)})
            alertController.addAction(alertaction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else if selectedButton.titleLabel?.text == "Mobile Phone" {
            
            let alertController = UIAlertController(title: "Success!", message: "An advisor will be in touch with you shortly. Please remember that the advisor will call your mobile phone:\n \(phoneNumberKit.format(phoneNumber, toType: .international)). \n The meeting is scheduled to be on \(dateFormatter.string(from: datePicker.date)) and will be about \(String(describing: btnSelectFinTopic.titleLabel!.text!)) \n", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "Confirm", style: .cancel, handler: {action in  self.presentingViewController?.dismiss(animated: true, completion: nil)})
            alertController.addAction(alertaction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    
    } catch {
        let alertController = UIAlertController(title: "Invalid Phone Number!", message: "The Phone Number you have provided is nOT real!", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertaction)
        self.present(alertController, animated: true, completion: nil)
    }
    }
}
    
}
