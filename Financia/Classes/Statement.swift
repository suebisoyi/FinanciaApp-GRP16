//
//  Statement.swift
//  Financia
//
//  Created by Said Abdikarim
//

import UIKit

class Statement: NSObject {

    var id : Int?
    var name : String?
    var type : String?
    var amount : Int?
    
    
    func initWithData(theRow i : Int, theName n : String, theType t : String, theAmount a : Int ){
        id = i
        name = n
        type = t
        amount = a
    }
}
