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
              
              var finalValue = 0.00
              if let doubleInterest = Double(interest.text!), let calcYears = Double(years.text!), let doubleCompound = Double(compoundRate.text!) {
                  var annualRate = doubleInterest / 100
                  
                    print("ss is " + ss)
              if(ss == "Present"){
                  finalValue = round(Double(money.text!)! / pow((1 + annualRate), calcYears * doubleCompound) * 100) / 100.0
                solution.text = "The above calculation shows you that the future value of $\(money.text ?? "") with \(interest.text!)% interest compounded \(Int(compoundRate.text!) ?? 0) times for \(Int(years.text!) ?? 0) year(s) is worth $\(finalValue) today."
              }
              else{
                  finalValue = round(Double(money.text!)! * pow((1 + annualRate), calcYears * doubleCompound) * 100) / 100.0
                solution.text = "The above calculation shows you that with $\(money.text ?? "") and you're earning \(interest.text!)% interest on that sum compounded \(compoundRate.text ?? "") for \(years.text ?? "0") year(s) is worth $\(finalValue)."
          }
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
