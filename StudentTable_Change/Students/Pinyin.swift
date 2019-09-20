//
//  Pinyin.swift
//  Students
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

extension String {
    
    func isIncludeChinese() -> Bool {
        for ch in self.unicodeScalars {
            if (0x4e00 < ch.value  && ch.value < 0x9fff) {
                return true
            }
        }
        return false
    }
    
    func transformToPinyin() -> String {
        let stringRef = NSMutableString(string: self) as CFMutableString

        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false);

        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false);
        var pinyin = stringRef as String
        
        pinyin = pinyin.replacingOccurrences(of: " ", with: "")
        return pinyin
    }
    
    func getHead() -> String {
        
        for ch in self.uppercased() {
            
            if ch >= "A" && ch <= "Z" {
                return "\(ch)"
            }
        }
        return ""
    }
}
