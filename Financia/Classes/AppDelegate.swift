//
//  AppDelegate.swift
//  Financia
//
//  Created by Gagandeep Ghotra on 2021-03-04.
//

import UIKit
import SQLite3
//import Auth0

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var databaseName: String? = "Financia-GKSH.db"
    var databasePath: String?
    var wordBankWords: [WordBankWords] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]

        databasePath = documentsDir.appending("/" + databaseName!)

        checkAndCreateDB()
        
        readDataFromDB()
        return true
    }
    
   /* func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return Auth0.resumeAuth(url, options: options)
    }*/
    
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
               var queryStatementString : String = "select * from WordBank"
               
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
                   print("SELECT statement could not be prepared")
               }
               
               sqlite3_close(db);
           }
           else
           {
               print("Unable to open database.")
           }
       
       }
       
     /*  func insertIntoDB(user : UserData) -> Bool
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
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
    }}

