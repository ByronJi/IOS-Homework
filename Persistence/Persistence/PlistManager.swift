//
//  PlistManager.swift
//  Persistence
//
//  Created by Byron on 2019/4/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

class PlistManager : PersistenceDelegate {
    
    public static let standard = PlistManager()
    private var fileURL : URL
    
    init() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        fileURL = urls.first!.appendingPathComponent("data.plist")

    }
    
    func loadData() -> [String] {
        if(FileManager.default.fileExists(atPath: fileURL.path)) {
            if let array = NSArray(contentsOf: fileURL) as? [String] {
                return array
            }
        }
        
        return []
    }
    
    func saveData(_ data: [String]) {
        let array = data as NSArray
        array.write(to: fileURL, atomically: true)
    }
    
}
