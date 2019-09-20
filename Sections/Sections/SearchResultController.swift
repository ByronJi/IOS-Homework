//
//  SerchResultController.swift
//  Sections
//
//  Created by Byron on 2019/4/6.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class SearchResultController
: UITableViewController,UISearchResultsUpdating {
    
    private static let longNameSize = 6
    private static let shortNameButtonIndex = 1
    private static let longNameButtonIndex = 2
    
    let sTabID = "SectionTableIdentifier"
    var names:[String:[String]]!
    var keys:[String]!
    var filiteredNames:[String] = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sTabID)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text{
            let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
            filiteredNames.removeAll(keepingCapacity: true)
            
            if !searchString.isEmpty{
                let filter:(String) -> Bool = { name in
                    let nameLenth = name.count
                    if(buttonIndex == SearchResultController.shortNameButtonIndex && nameLenth >= SearchResultController.longNameSize) || (buttonIndex == SearchResultController.longNameButtonIndex && nameLenth < SearchResultController.longNameSize){
                        return false
                    }
                    
                    let range = name.range(of: searchString, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
                    
                    return range != nil
                }
                for key in keys{
                    let namesForKey = names[key]!
                    let matches = namesForKey.filter(filter)
                    filiteredNames += matches
                }
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filiteredNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sTabID, for: indexPath) as UITableViewCell
        cell.textLabel?.text = filiteredNames[indexPath.row]
        return cell
    }
    
}
