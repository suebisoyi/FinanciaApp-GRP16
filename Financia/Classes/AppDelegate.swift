
//
//  AppDelegate.swift
//  Financia
//
//  Created by Gagandeep Ghotra on 2021-03-04.
//

import UIKit
import SQLite3
import Auth0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var databaseName: String? = "Financia.db"
    var databasePath: String?
    var wordBankWords: [WordBankWords] = []
    
    var stmt: [Statement] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]

        databasePath = documentsDir.appending("/" + databaseName!)

        checkAndCreateDB()
        
        readDataFromDB()
       // readFromDatabasePlanTable()
        
        return true
    }
    
   func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return Auth0.resumeAuth(url, options: options)
    }
    
    func checkAndCreateDB(){
        
        var success = false
        let fileManager = FileManager.default
        success = fileManager.fileExists(atPath: databasePath!)
       
        if success
        {
            return
        }
           
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
           
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
           
        return;
           
    }

    func readDataFromDB(){
     
       wordBankWords.removeAll()
       
           var db: OpaquePointer? = nil
           
           if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
               print("Successfully opened connection to database at \(self.databasePath)")
               
               var queryStatement: OpaquePointer? = nil
               var queryStatementString : String = "SELECT * FROM WordBank"
               
               if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                   
                   while( sqlite3_step(queryStatement) == SQLITE_ROW ) {
                   
                       let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                       let cwordName = sqlite3_column_text(queryStatement, 1)
                       let cwordDefinition = sqlite3_column_text(queryStatement, 2)
                       let cwordExampleUses = sqlite3_column_text(queryStatement, 3)

                       let wordName = String(cString: cwordName!)
                       let wordDefinition = String(cString: cwordDefinition!)
                       let wordExampleUses = String(cString: cwordExampleUses!)

                                           
                       let data : WordBankWords = WordBankWords.init()

                    data.initWithWord(wordID: id, wordName: wordName, wordDefinition: wordDefinition, wordExampleUses: wordExampleUses)
                    
                       wordBankWords.append(data)
                       
                       print("Query Result:")
                       print("\(id) | \(wordName) | \(wordDefinition)| \(wordExampleUses)")
                   }
                   sqlite3_finalize(queryStatement)
                   
               }
               else
               {
                    let errmsg = String(cString: sqlite3_errmsg(db))
                    fatalError("Failed to prepare table creation SQL: \(errmsg)")
                                 print("SELECT statement could not be prepared")
               }
             sqlite3_close(db);
           }
           else
           {
               print("Unable to open database.")
           }
       
       }
       
      /* func insertIntoDB(user : UserData) -> Bool
       {
           var db: OpaquePointer? = nil
           var returnCode : Bool = true
           
           if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
               print("Successfully opened connection to database at \(self.databasePath)")
               
               var insertStatement: OpaquePointer? = nil
               let insertStatementString : String = "insert into WordBank values(NULL, ?, ?, ?, ?, ?, ?, ?)"
               
               if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                  
                let nameStr = user.userName! as NSString
                let emailStr = user.userEmail! as NSString
                let addressStr = user.userAddress! as NSString
                let numberStr = user.userNumber! as NSString
                let ageStr = user.userAge! as NSString
                let avatarInt = user.userAvatarID! as NSInteger
                let genderStr = user.userGender! as NSString

                   sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                   sqlite3_bind_text(insertStatement, 2, emailStr.utf8String, -1, nil)
                   sqlite3_bind_text(insertStatement, 3, addressStr.utf8String, -1, nil)
                   sqlite3_bind_text(insertStatement, 4, numberStr.utf8String, -1, nil)
                   sqlite3_bind_text(insertStatement, 5, ageStr.utf8String, -1, nil)
                   sqlite3_bind_text(insertStatement, 6, genderStr.utf8String, -1, nil)
                   sqlite3_bind_int(insertStatement, 7, Int32(avatarInt))

                   if sqlite3_step(insertStatement) == SQLITE_DONE {
                       let rowID = sqlite3_last_insert_rowid(db)
                       print("Successfully inserted row. \(rowID)")
                   } else {
                       print("Could not insert row.")
                       returnCode = false
                   }
                   sqlite3_finalize(insertStatement)
               } else {
                   print("INSERT statement could not be prepared.")
                   returnCode = false
               }
               
               sqlite3_close(db);
               
           } else {
               print("Unable to open database.")
               returnCode = false
           }
           return returnCode
       }*/
    
//---------------------------------------
    func deleteRowPlan(statementId : Int) {
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
    
        
    func readFromDatabasePlanTable() -> [Statement]? {
        stmt.removeAll()
        var statementArray = [Statement]()
        
        var db : OpaquePointer? = nil
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened the connection read")
            
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
    
    func insertStatementIntoPlan(name : String, type: String, amount : Int){
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection at \(self.databasePath) insert")
            
        var insertStatement : OpaquePointer? = nil
                        
        let insertStatementQuery : String = "Insert into plan (Name, Type, Amount) Values ('\(name)', '\(type)', '\(amount)')"
        
            if sqlite3_prepare_v2(db, insertStatementQuery, -1, &insertStatement, nil) == SQLITE_OK {
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("inserted successfully")
                }else{
                    print("not inserted, something went wrong!")
                }
                sqlite3_finalize(insertStatement)
                readFromDatabasePlanTable()
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
            print("Successfully opened the connection calculate")
            
            var queryStatement : OpaquePointer? = nil
            var queryStatementString : String = "SELECT (Select COALESCE(SUM(Amount), 0) AS INCOME FROM plan WHERE Type = 'Income') - (Select COALESCE(SUM(Amount), 0) FROM plan where type = 'Expense')"
        
            
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
    
    func sumExpensesIncome() -> [Int] {
        var total : [Int] = []

    
        var db : OpaquePointer? = nil
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened the connection calculate")
            
            var queryStatement : OpaquePointer? = nil
            var queryStatementString : String = "select sum(amount) from plan group by Type"

            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                      while sqlite3_step(queryStatement) == SQLITE_ROW
                      {
                          let sum : Int = Int(sqlite3_column_int(queryStatement, 0))
                          
                            total.append(sum)
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
}

func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
    } 
