//
//  CFViewController.swift
//  Financia
//
//

import UIKit
import SQLite3

class CFViewController: UIViewController {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet var lblTable : UILabel!

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
    
    @IBAction func unwindToBudgetController(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountField.delegate = self
        amountField.keyboardType = UIKeyboardType.numberPad
    }
    
    @IBAction func saveStatement(_ sender: Any) {
        let type = statementType
        let amt = Int(amountField.text!)
        dummyAmount = amt!
        
        if(amountField.text == "" || amountField.text == nil || dummyAmount <= 0 || ((amountField.text?.isEmpty) == nil) || nameField.text == "" || nameField.text?.count == 0){
            print("amount is incorrect or empty")
            
            let alert = UIAlertController(title: "Warning", message: "You  have not completed the form, complete the missing fields.", preferredStyle: .alert)
                        
                        let continueAction = UIAlertAction(title: "Ok, I got it!", style: .default, handler: nil)
                        
                        alert.addAction(continueAction)
                        present(alert, animated: true)
        }else{
            print("Data is not empty, preparing to insert")
            mainDelegate.insertStatement(name: nameField.text!, type: statementType, amount: dummyAmount)
            amountField.text = ""
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
        amountField.resignFirstResponder()
        nameField.resignFirstResponder()
        return true
    }
}
 
