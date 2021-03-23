//
//  AdvisorChatController.swift
//  Financia
//
//  Created by Sudikshya on 2021-03-04.
//

import UIKit

class AdvisorChatController: UIViewController {
    
    //@IBOutlet weak var sgDiff: UISegmentedControl!
    @IBOutlet var lbTimePrefTitle: UILabel!
    
    @IBOutlet var sgTime: UISegmentedControl!
    
    @IBOutlet var lblTimeAdvisorTitle: UILabel!
    @IBOutlet var btnBookAppt: UIButton!
    
    @IBOutlet var lblTimePrefA: UILabel!
    @IBOutlet var lblTimePrefB: UILabel!
    @IBOutlet var lblTimePrefC: UILabel!
    @IBOutlet var lblTimePrefD: UILabel!
    @IBOutlet var lblTimePrefE: UILabel!
    @IBAction func unwindToAdvisorPickerViewController(sender : UIStoryboardSegue){
        
    }
@IBAction func updateLabels(sender : Any){
        
        let alert = UIAlertController(title: "Message", message: "Thank you for booking an appointment with\(lbTimePrefTitle.text!) \n  Are you sure you want to proceed?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default,
                    handler:{(alert: UIAlertAction!) in
                                           self.dismiss(animated: true, completion: nil)
            })
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil )
         
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
        
    }
    
    func updateTimePreference(){
        let timePreference = sgTime.selectedSegmentIndex
        
        if timePreference == 0{
            lbTimePrefTitle.text = "Selected Time Preference: Monday"
        }
        else if timePreference == 1{
            lbTimePrefTitle.text = "Selected Time Preference: Tuesday"
        }
        else if timePreference == 2{
            lbTimePrefTitle.text = "Selected Time Preference: Wednesday"
        }
        else if timePreference == 3{
            lbTimePrefTitle.text = "Selected Time Preference: Thursday"
        }
        else if timePreference == 4{
            lbTimePrefTitle.text = "Selected Time Preference: Friday"
        }
    }
    
    @IBAction func segmentDidChange(sender : UISegmentedControl){
        updateTimePreference()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimePreference()
    }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
