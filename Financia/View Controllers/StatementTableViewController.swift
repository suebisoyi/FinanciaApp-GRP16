//
//  StatementTableViewController.swift
//  Financia
//
//  Created by  on 4/10/21.
//

import UIKit

class StatementTableViewController: UITableViewController {

    private var viewModel = StatementViewModel()
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Budget Statement"
    
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        tableView.reloadData()
        
        let net = mainDelegate.calculateNet()
        let controller = UIAlertController(title: "Net Balance", message: "Your current net balance is $\(net).", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(ok)
        present(controller, animated: true, completion: nil)    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    private func loadData() {
        viewModel.loadDataFromSQL()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let obj = viewModel.cellForRowAt(indexPath: indexPath)

        if let statementCell = cell as? StatementTableViewCell {
            print(obj)
            statementCell.setCellWithValues(obj)
            if(statementCell.typeLabel.text == "Expense"){
                statementCell.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 203/255, alpha: 1)
            }else{
                statementCell.backgroundColor = UIColor(red: 173/255, green: 223/255, blue: 172/255, alpha: 1)
            }
            
        }else{
            print("Something went wrong with table cell")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("thinking about deleting")
        if(editingStyle == .delete){
            print("Deleting now")
            let statement = viewModel.cellForRowAt(indexPath: indexPath)
            print("attempting to delete" + statement.name!)
            mainDelegate.deleteRow(statementId: statement.id!)
            
            self.loadData()
            self.tableView.reloadData()
        }else{
            print("delete was not called")
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
