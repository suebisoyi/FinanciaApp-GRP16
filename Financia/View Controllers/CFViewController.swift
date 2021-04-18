//
//  CFViewController.swift
//  Financia
// Created by Said Abdikarim
//

import UIKit
import SQLite3

class CFViewController: UIViewController {

    @IBOutlet weak var amountField: UISlider!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet var lblTable : UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var showGraphButton: UIButton!
    @IBOutlet weak var incomeExpenseSwitch: UISegmentedControl!
    var viewModle : NewStatementViewModel!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var statementType = "Income"
    var dummyAmount : Int = -1
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch = touches.first!
        let touchPoint : CGPoint = touch.location(in: self.view!)
        
        let tableFrame : CGRect = lblTable.frame
        
        if tableFrame.contains(touchPoint){
            performSegue(withIdentifier: "FormSegueToTable", sender: self)
        }
    }
    
    @IBAction func onSlliderChange(_ sender: UISlider) {
        amountLabel.text = "The amount is $\(Int(sender.value))"
    }
    
    
    @IBAction func unwindToBudgetController(segue: UIStoryboardSegue){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        amountField.value = 250
        amountLabel.text = "The amount is $\(Int(amountField.value))"
    }
    
    
    @IBAction func onClickGraph(_ sender: UIButton) {
        performSegue(withIdentifier: "formToGraphic", sender: self)
    }
    
    
    
    @IBAction func saveStatement(_ sender: Any) {
        let type = statementType
        let amt = Int(amountField.value)
        dummyAmount = amt
        
        if(nameField.text == "" || nameField.text?.count == 0){
            print("name is empty")
            
            let alert = UIAlertController(title: "Warning", message: "You  have not completed the form, complete the missing fields.", preferredStyle: .alert)
                        
                        let continueAction = UIAlertAction(title: "Ok, I got it!", style: .default, handler: nil)
                        
                        alert.addAction(continueAction)
                        present(alert, animated: true)
        }else{
            print("Data is not empty, preparing to insert")
            mainDelegate.insertStatementIntoPlan(name: nameField.text!, type: statementType, amount: dummyAmount)
            amountField.value = 1
            nameField.text = ""
           }
        }
        
    @IBAction func indexChanged(_ sender: Any) {
    
        switch incomeExpenseSwitch.selectedSegmentIndex {
        case 0:
            statementType = "Income"
            break
        case 1:
            statementType = "Expense"
            break
        default:
            break
        }
    }
}

extension CFViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        return true
    }
}
 
