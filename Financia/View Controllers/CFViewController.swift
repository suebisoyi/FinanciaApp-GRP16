//
//  CFViewController.swift
//  Financia
//

import UIKit

class CFViewController: UIViewController {
    @IBOutlet weak var fieldSideIncome: UITextField!
    @IBOutlet weak var fieldExpenses: UITextField!
    @IBOutlet weak var fieldIncome: UITextField!
    @IBOutlet weak var statement: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statement.isHidden = true
    }
    
    
    @IBAction func calculateButton(_ sender: Any) {
        let mainIncome = Double(fieldIncome.text!)
        var sideIncome = Double(fieldSideIncome.text!)
        let expenses = Double(fieldExpenses.text!)
        statement.isHidden = false
        if(mainIncome != nil && expenses != nil){
            if(sideIncome == nil){
                sideIncome = 0
            }
            if(mainIncome! + sideIncome! - expenses! < 0){
                statement.text = "Deficit Cast!\nExpenses are greater than income!\nYour current cashflow is \(mainIncome! + sideIncome! - expenses!)."
                statement.textColor = UIColor.red
            }else{
                statement.text = "Surplus Cast!\nIncome is greater than total expenses!\nYour currebt cashflow is \(mainIncome! + sideIncome! - expenses!)."
                statement.textColor = UIColor.green
            }
        }else{
            statement.textColor = UIColor.red
            if(fieldIncome == nil){
                statement.text = "Income Field is missing!"
            }else{
                statement.text = "Expenses Field is missing!"
            }
        }
    }
    
}
    
