//
//  WordBankTableController.swift
//  Financia
//
//  Created by Gagandeep Ghotra

import UIKit

class WordBankTableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var wordsInTable: UITableView!
    //@IBOutlet weak var tableView: UITableView!
    //let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.wordBankWords.count
    }

    func tableView( _tableView: UITableView, _heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let tableCell  = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")

        let rowNum = indexPath.row
        
        tableCell.primaryLabel.text = "\(mainDelegate.wordBankWords[rowNum].wordName!)"
        
        tableCell.accessoryType = .disclosureIndicator

        return tableCell
    }

    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowNum = indexPath.row

        let alertController = UIAlertController(title:"Definition for \(mainDelegate.wordBankWords[rowNum].wordName!)", message: " \(String(describing: mainDelegate.wordBankWords[rowNum].wordDefinition!))\n\n The example uses are:  \(String(describing: mainDelegate.wordBankWords[rowNum].wordExampleUses!)) \n", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)

        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        wordsInTable.backgroundView  = UIImageView(image: UIImage(named: "tablebackground.jpg"))

        mainDelegate.readDataFromDB()
    }}
