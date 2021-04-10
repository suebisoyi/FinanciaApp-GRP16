//
//  StatementViewModel.swift
//  Financia
//
//  Created by  on 4/10/21.
//

import UIKit

class StatementViewModel: UIViewController {

    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var statementArray = [Statement]()
    
    func loadDataFromSQL() {
        statementArray = mainDelegate.readFromDatabase() ?? []
        print("loadDataFromSQL was called, length of statement array is " + String(statementArray.count))
    }

    
    func numberOfRowsInSection(section : Int) -> Int {
        print("num of rows was called, length of rows are " + String(statementArray.count))
        if(statementArray.count != 0){
            return statementArray.count
        }
        return 0
    }

    func cellForRowAt (indexPath: IndexPath) -> Statement {
        
        return statementArray[indexPath.row]
    }
    
}
