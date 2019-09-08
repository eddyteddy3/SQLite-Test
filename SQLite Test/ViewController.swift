//
//  ViewController.swift
//  SQLite Test
//
//  Created by Moazzam Tahir on 09/09/2019.
//  Copyright © 2019 Moazzam Tahir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var statusTextField: UILabel!
    
    let fileMng = FileManager.default
    var databasePath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func initDatabase() {
        let dirPath = fileMng.urls(for: .documentDirectory, in: .userDomainMask)
        
        //appending the database file .db in document directory.
        databasePath = dirPath[0].appendingPathComponent("contacts.db").path
        
        if !fileMng.fileExists(atPath: databasePath) {
            //initialized the FMDB at the previous path
            let contactDB = FMDatabase(path: databasePath)
            
            //opening the FMdatabase connection
            if (contactDB.open()) {
                let sql_statement = "create table if exits contact (id integer primary key autoincrement, Name text, Address text, Phone integer)"
                if !contactDB.executeStatements(sql_statement) {
                    print("Error Craeting table: \(contactDB.lastErrorMessage())")
                }
                //closing the connection
                contactDB.close()
            } else {
                print("Error opening connection: \(contactDB.lastErrorMessage())")
            }
        }
    }

    @IBAction func saveRecord(_ sender: Any) {
    }
    
    @IBAction func fetchRecord(_ sender: Any) {
    }
}

