//
//  AppDelegate.swift
//  Financia
//
//  Created by Sudikshya on 2021-03-04.
//

import UIKit
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var databaseName : String? = "MyBudgets.db"
    var databasePath : String?
    var stmt: [Statement] = []


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentDir = documentPaths[0]
        databasePath = documentDir.appending("/" + databaseName!)
        
        checkAndCreateDatabase()
        readFromDatabase()
        return true
    }
    
    func deleteRow(statementId : Int) {
        var db : OpaquePointer? = nil
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened the connection")
            let deleteStatementString = "DELETE FROM plan WHERE ID = \(statementId)"
            var deleteStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(statementId))
               if sqlite3_step(deleteStatement) == SQLITE_DONE {
                   print("Successfully deleted row.")
               } else {
                   print("Could not delete row.")
               }
           } else {
               print("DELETE statement could not be prepared")
           }
        }else{
            print("DB failed to connect!")
        }
    }
    
    func checkAndCreateDatabase() {
        var success = false
        let fm = FileManager.default
        success = fm.fileExists(atPath: databasePath!)
        
        if(success){
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        try? fm.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
    }
        
    func readFromDatabase() -> [Statement]? {
        stmt.removeAll()
        var statementArray = [Statement]()
        
        var db : OpaquePointer? = nil
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened the connection")
            
            var queryStatement : OpaquePointer? = nil
            var queryStatementString : String = "Select * from plan"
        
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW
                {
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cname = sqlite3_column_text(queryStatement, 1)
                    let ctype = sqlite3_column_text(queryStatement, 2)
                    let camt : Int = Int(sqlite3_column_int(queryStatement, 3))
                    
                    let type = String(cString: ctype!)
                    let name = String(cString : cname!)
                    let statement : Statement = Statement.init()
                    
                    statement.initWithData(theRow: id, theName : name, theType: type, theAmount: camt)
            
                    statementArray.append(statement)
                    stmt.append(statement)
                    
                    print("Testing query result.")
                    print("\(id) | \(name) | \(type) | \(camt)")
                }
            }else{
                print("Select statement could not be prepapred!")
            }
            sqlite3_finalize(queryStatement)
            sqlite3_close(db)
        }else{
            print("Unable to open db")
        }
        return statementArray
    }
    
    func insertStatement(name : String, type: String, amount : Int){
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection at \(self.databasePath)")
            
        var insertStatement : OpaquePointer? = nil
                        
        let insertStatementQuery : String = "Insert into plan (Name, Type, Amount) Values ('\(name)', '\(type)', '\(amount)')"
        
            if sqlite3_prepare_v2(db, insertStatementQuery, -1, &insertStatement, nil) == SQLITE_OK {
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("inserted successfully")
                }else{
                    print("not inserted, something went wrong!")
                }
                sqlite3_finalize(insertStatement)
                readFromDatabase()
            }else{
                print("prepared statement failed!")
            }
        }else{
        print("unable to connect to DB")
        }
    }
    
    func calculateNet() -> Int {
        var total : Int = 0
    
        var db : OpaquePointer? = nil
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened the connection")
            
            var queryStatement : OpaquePointer? = nil
            var queryStatementString : String = "SELECT (Select SUM(Amount) AS INCOME FROM plan WHERE Type = 'Income') - (Select sum(Amount) FROM plan where type = 'Expense')"
        
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW
                {
                    total = Int(sqlite3_column_int(queryStatement, 0))
        
                    print("Testing tough query result.")
                    print("\(total)")
                }
            }else{
                print("Select statement could not be prepapred!")
            }
            sqlite3_finalize(queryStatement)
            sqlite3_close(db)
        }else{
            print("Unable to open db")
        }
        return total
    }

func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

