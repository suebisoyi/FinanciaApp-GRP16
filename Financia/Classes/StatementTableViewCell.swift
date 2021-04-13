//
//  StatementTableViewCell.swift
//  Financia
//
//  Created by Said Abdikarim
//

import UIKit

class StatementTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    
    
    //set up statement values
    
    func setCellWithValues(_ statement : Statement){
        nameLabel.text = statement.name
        typeLabel.text = statement.type
        priceLabel.text = "$" + String(statement.amount!)
    }

}
