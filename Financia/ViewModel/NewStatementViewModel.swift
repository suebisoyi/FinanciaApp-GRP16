//
//  NewStatementViewModel.swift
//  Financia
//
//  Created by  on 4/10/21.
//

import UIKit

class NewStatementViewModel {

    private var statementValues : Statement?
    
    let id : Int?
    let name : String?
    let type : String?
    let amt : Int?
    
    init(statementValues : Statement?){
        self.statementValues = statementValues
        self.id = statementValues?.id
        self.name = statementValues?.name
        self.type = statementValues?.type
        self.amt = statementValues?.amount
    }

}
