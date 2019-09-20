//
//  LoginUserInfo.swift
//  login
//
//  Created by Byron on 2019/5/7.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

class LoginUserInfo: NSObject, NSCoding {
    
    //let filePath = NSHomeDirectory() + "/Documents/contacts.data"
    public var sessionToken: String?
    public var userCode: String?
    public var userName: String?
    public var roleName: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.sessionToken = aDecoder.decodeObject(forKey: "sessionToken") as? String
        self.userCode = aDecoder.decodeObject(forKey: "userCode") as? String
        self.userName = aDecoder.decodeObject(forKey: "userName") as? String
        self.roleName = aDecoder.decodeObject(forKey: "roleName") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.sessionToken,forKey: "sessionToken")
        aCoder.encode(self.userCode,forKey: "userCode")
        aCoder.encode(self.userName,forKey: "userName")
        aCoder.encode(self.roleName,forKey: "roleName")
    }
    
    override init()
    {
        
    }
}
