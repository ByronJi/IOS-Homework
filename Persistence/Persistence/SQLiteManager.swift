//
//  SQLiteManager.swift
//  Persistence
//
//  Created by Byron on 2019/4/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteManager: PersistenceDelegate {
    
    public static let standard = SQLiteManager()
    private var dbPath : String = ""
    
    init() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls.first!.appendingPathComponent("data.sqlite3")
        dbPath = url.path
    }
    
    func loadData() -> [String] {
        var datalist : [String] = []
        
        var database : OpaquePointer? = nil
        var res = sqlite3_open(dbPath, &database)
        if res != SQLITE_OK {
            sqlite3_close(database)
            print("open database error")
            return datalist
        }
        
        let createsql = "Create Table If Not Exists Fields(Row Integer Primary Key, Field_Data Text);"
        var errmsg : UnsafeMutablePointer<Int8>? = nil
        res = sqlite3_exec(database, createsql, nil, nil, &errmsg)
        if res != SQLITE_OK {
            sqlite3_close(database)
            print("Create Table error")
            return datalist
        }
        
        let query = "Select Field_Data From Fields Order by Row"
        var statmt : OpaquePointer? = nil
        if sqlite3_prepare_v2(database, query, -1, &statmt, nil) == SQLITE_OK {
            while sqlite3_step(statmt) == SQLITE_ROW {
                let rowData = sqlite3_column_text(statmt, 0)
                let fieldValue = String.init(cString: rowData!)
                datalist.append(fieldValue)
            }
            sqlite3_finalize(statmt)
        }
        sqlite3_close(database)
        return datalist
    }
    
    func saveData(_ data: [String]) {
        var database : OpaquePointer? = nil
        let res = sqlite3_open(dbPath, &database)
        if res != SQLITE_OK {
            sqlite3_close(database)
            print("open database error")
            return
        }
        
        for i in 0..<data.count {
            let field_data = data[i]
            let update = "Insert or Replace Into Fields(Row, Field_data) Values( ?, ? )"
            var statmt : OpaquePointer? = nil
            if sqlite3_prepare_v2(database, update, -1, &statmt, nil) == SQLITE_OK {
                sqlite3_bind_int(statmt, 1, Int32(i))
                sqlite3_bind_text(statmt, 2, field_data, -1, nil)
            }
            if sqlite3_step(statmt) != SQLITE_DONE {
                sqlite3_close(database)
                print("insert or update error")
            }
            sqlite3_finalize(statmt)
        }
        sqlite3_close(database)
    }
    
    
}
