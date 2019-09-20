//
//  PersistenceDelegate.swift
//  Persistence
//
//  Created by Byron on 2019/4/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

protocol PersistenceDelegate {
    func loadData() -> [String]
    func saveData(_ data: [String])
}
