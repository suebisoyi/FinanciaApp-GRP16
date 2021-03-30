//
//  CFViewController.swift
//  Financia
//

import UIKit

class CFViewController: UIViewController {
    @IBOutlet weak var fieldSideIncome: UITextField!
    @IBOutlet weak var fieldIncome: UITextField!
    @IBOutlet weak var expense3: UITextField!
    @IBOutlet weak var expense2: UITextField!
    @IBOutlet weak var expense1: UITextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    var mainIncome = 0
    var sideIncome = 0
    var e1 = 0
    var e2 = 0
    var e3 = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fieldSideIncome.delegate = self
        fieldIncome.delegate = self
        expense3.delegate = self
        expense2.delegate = self
        expense1.delegate = self
    }
    
    
    @IBAction func nextStep(_ sender: UIButton) {
        self.mainIncome = Int(fieldIncome.text!)!
        self.sideIncome = Int(fieldSideIncome.text!)!
        self.e1 = Int(expense1.text!)!
        self.e2 = Int(expense2.text!)!
        self.e3 = Int(expense3.text!)!
        performSegue(withIdentifier: "finishSetup", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "finishSetup"){
            let vc = segue.destination as! FinalCFViewController
            vc.income = self.mainIncome
            vc.sideIncome = self.sideIncome
            vc.expense1 = self.e1
            vc.expense2 = self.e2
            vc.expense3 = self.e3
        }
    }
    
}

extension CFViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }}
