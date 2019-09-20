//
//  AppArchiver.swift
//  login
//
//  Created by Byron on 2019/5/7.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

class AppArchiver{
    
    //let path =
    static let share = AppArchiver()
    private var fileURL:URL
    
    init(){
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        fileURL = (urls.first?.appendingPathComponent("appdata.archive"))!
    }
    
    func write(userInfo: LoginUserInfo)
    {
        
        //let data = NSMutableData()
        do {
            let data = try! NSKeyedArchiver.archivedData(withRootObject: userInfo, requiringSecureCoding: false)
            //archiver.encode(userInfo, forKey: "userInfo")
            //archiver.finishEncoding()
            try data.write(to: fileURL)
            
        } catch {
            print("Couldn't write to save file: " + error.localizedDescription)
        }
        
        
    }
    
    func read() -> LoginUserInfo? {
        
        
        let codedData = try? Data(contentsOf: fileURL)
        
        // 3
        let userInfo =  try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData!) as? LoginUserInfo
        return userInfo ?? nil
        
    }
}
