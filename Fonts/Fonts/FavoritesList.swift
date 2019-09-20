//
//  File.swift
//  Fonts
//
//  Created by Byron on 2019/4/6.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit

class FavoritesList{
    static let sharedFavoritesList = FavoritesList()
    private(set) var favorites:[String]
    
    init(){
        let defaults = UserDefaults.standard
        let storedFavorites = defaults.object(forKey: "favorites") as? [String]
        favorites = storedFavorites != nil ? storedFavorites! : []
    }
    
    func addFavorite(fontName:String){
        if !favorites.contains(fontName)
        {
            favorites.append(fontName)
            saveFavorite()
        }
    }
    
    func removeFavorite(fontName:String){
        if let index = favorites.firstIndex(of:fontName){
            favorites.remove(at: index)
            saveFavorite()
        }
    }
    
    func saveFavorite(){
        let defaults = UserDefaults.standard
        defaults.set(favorites, forKey: "favorites")
        defaults.synchronize()
    }
    
    func moveItem(fromIndex from:Int, toIndex to:Int){
        let item = favorites[from]
        favorites.remove(at: from)
        favorites.insert(item, at: to)
        saveFavorite()
    }
}
