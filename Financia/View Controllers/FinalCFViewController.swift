//
//  FinalCFViewController.swift
//  Financia
//
//  Created by  on 3/30/21.
//

import UIKit

class FinalCFViewController: UIViewController {

    @IBOutlet weak var expense4: UITextField!
    @IBOutlet weak var statement: UILabel!
    @IBOutlet weak var expense7: UITextField!
    @IBOutlet weak var expense5: UITextField!
    @IBOutlet weak var expense6: UITextField!
    @IBOutlet weak var otherExpense: UITextField!
    
    var income = 0
    var sideIncome = 0
    var expense1 = 0
    var expense2 = 0
    var expense3 = 0
    var e4 = 0
    var e5 = 0
    var e6 = 0
    var e7 = 0
    var otherExpenses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statement.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        let mainIncome = Double(income)
        var sideOtherIncome = Double(sideIncome)
        let expenses = Double(expense1 + expense2 + expense3)
        statement.isHidden = false
        var totalExpenses = 0
        if(expense4.text == nil){
            e4 = 0;
            totalExpenses += e4;
        }
        
        if(expense5 == nil){
            e5 = 0;
            totalExpenses += e5;
        }
        
        if(expense6 == nil){
            e6 = 0;
            totalExpenses += e6;
        }
        
        if(expense7 == nil){
            e7 = 0;
            totalExpenses += e7;
        }
        
        if(otherExpense.text == nil){
            otherExpenses = 0;
            totalExpenses += otherExpenses;
        }
        
        if(mainIncome != nil && expenses != nil){
            if(sideIncome == nil){
                sideIncome = 0
            }
            if(Int(mainIncome!) + sideIncome! - (expenses! + totalExpenses) < 0){
                statement.text = "Deficit Cast!\nExpenses are greater than income!\nYour current cashflow is \(mainIncome! + Double(sideIncome!) - expenses!  - totalExpenses)."
                statement.textColor = UIColor.red
            }else{
                statement.text = "Surplus Cast!\nIncome is greater than total expenses!\nYour current cashflow is \(mainIncome! + Double(sideIncome!) - expenses! - totalExpenses)."
                statement.textColor = UIColor.green
            }
        }else{
            statement.textColor = UIColor.red
            if(income == nil){
                statement.text = "Income Field is missing!"
            }else{
                statement.text = "Expenses Field is missing!"
            }
        }
    }

}
