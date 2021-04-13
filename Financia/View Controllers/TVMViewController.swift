//
//  TVMViewController.swift
//  Financia
// Created by Said Abdikarim
//

import UIKit

class TVMViewController: UIViewController {

    @IBOutlet weak var interest: UITextField!
    @IBOutlet weak var money: UITextField!
    @IBOutlet weak var calculate: UIButton!
    @IBOutlet weak var solution: UILabel!
    @IBOutlet weak var compoundRate: UITextField!
    @IBOutlet weak var valueSwitch: UISegmentedControl!
    var ss : String = ""
    @IBOutlet weak var years: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        money.delegate = self
        interest.delegate = self
        compoundRate.delegate = self
        years.delegate = self
    }
    

    @IBAction func onCalculate(_ sender: Any) {
    
        if(interest.text == "" || money.text == "" || compoundRate.text == "" || years.text == ""){
            solution.text = "At least one of the fields is missing values!";
        }else{
            //FV = $5,000 x (1 + (5% / 1) ^ (1 x 2) = $5,512.50
            //PV = $1,100 / (1 + (5% / 1) ^ (1 x 1) = $1,047
            
            
            var finalValue = 0.00
            if let doubleInterest = Double(interest.text!), let calcYears = Double(years.text!), let doubleCompound = Double(compoundRate.text!) {
                finalValue = Double(1 + pow(((doubleInterest / 100) / doubleCompound), calcYears))
            }
                    
            if(ss == "Present"){
                solution.text = String(Double(money.text!)! * finalValue) + ".\nThe above calculation shows you that with a \(interest.text)% compounded \(compoundRate.text) times for \(years.text) year(s)."
            }
            else{
                solution.text = String(Double(money.text!)! / finalValue) + ".\nThe above calculation shows you that with $\(money.text) and you're earning \(interest.text)% interest on that sum compounded for \(compoundRate.text) for \(years.text) year(s)."
            }
        }
    }
    
    
    @IBAction func switchChange(_ sender: UISwitch) {
        switch valueSwitch.selectedSegmentIndex {
            case 0:
                ss = "Present"
            case 1:
                ss = "Future"
            default:
                ss = "Present"
                break
            }
}

}


extension TVMViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        money.resignFirstResponder()
        interest.resignFirstResponder()
        years.resignFirstResponder()
        compoundRate.resignFirstResponder()
        return true
    }}
