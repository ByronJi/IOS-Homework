//
//  ResultsTableViewController.swift
//  Students
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController,UISearchResultsUpdating {
    
    var childrenNameDict:[String:[(String,String)]] = [:]
    var filterNames:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NameCell")
    }

    // MARK: - Table view data source

   func updateSearchResults(for searchController: UISearchController) {
        filterNames.removeAll()
        let searchText = searchController.searchBar.text

        for pairs in childrenNameDict.values {
            for (name, pinyin) in pairs {
                if pinyin.range(of: searchText!, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil) != nil {
                        filterNames.append(name)
                }
            }
        }
            
            tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)

        // Configure the cell...

        cell.textLabel?.text = filterNames[indexPath.row]
        
        return cell
    }

}
