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
        statusTextField.isHidden = true
        initDatabase()
    }
    
    func initDatabase() {
        let dirPath = fileMng.urls(for: .documentDirectory, in: .userDomainMask)
        
        //appending the database file .db in document directory.
        databasePath = dirPath[0].appendingPathComponent("contacts.db").path
        
        //if file not exists already
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
        } else {
            print("File already exits")
        }
    }

    @IBAction func saveRecord(_ sender: Any) {
        let name = nameTextField.text
        let address = addressTextField.text
        let phone = phoneTextField.text
        
        //initializing the FMDatabase to fetch the results
        let contactDB = FMDatabase(path: databasePath)
        
        //opening the database connection
        if (contactDB.open()) {
            //inserting into table
            let insertSqlQuery = "insert into contact (Name, Address, Phone) values (\(name ?? ""), \(address ?? ""), \(phone ?? ""))"
            
            //executing the query
            do {
                try contactDB.executeUpdate(insertSqlQuery, values: nil)
            } catch {
                print("Insert record error: \(contactDB.lastErrorMessage())")
                print(error.localizedDescription)
            }
            
            statusTextField.isHidden = false
            statusTextField.text = "Record Saved!"
            statusTextField.textColor = .red
            nameTextField.text = ""
            addressTextField.text = ""
            phoneTextField.text = ""
        } else {
            print("database connection error: \(contactDB.lastErrorMessage())")
        }
        
        contactDB.close()
        
    }
    
    @IBAction func fetchRecord(_ sender: Any) {
        
        
    }
}

