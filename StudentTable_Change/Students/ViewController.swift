//
//  ViewController.swift
//  Students
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allChildrenNames:[String]!
    var childrenNameDict:[String:[(String,String)]] = [:]
    var keys:[String]!
    var searchController:UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NameCell")
        let url = Bundle.main.url(forResource: "children", withExtension: "plist")
        allChildrenNames = (NSArray(contentsOf: url!) as? [String])?.sorted()
        for name in allChildrenNames{
            let pinyin = name.transformToPinyin()
            let sec = pinyin.getHead()
            
            let ar = childrenNameDict[sec]
            if ar == nil{
                childrenNameDict[sec] = [(name,pinyin)]
            }else{
                childrenNameDict[sec]?.append((name,pinyin))
            }
        }
        keys = childrenNameDict.keys.sorted()
        
        let searchResult = ResultsTableViewController()
        searchResult.childrenNameDict = self.childrenNameDict
        searchController = UISearchController(searchResultsController: searchResult)
        
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Enter a search term"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        
        searchController.searchResultsUpdater = searchResult
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = keys[section]
        return childrenNameDict[sec]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "NameCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "NameCell")
        }
        
        let sec = keys[indexPath.section]
        let (name, pinyin) = childrenNameDict[sec]![indexPath.row]
        
        cell?.textLabel?.text = name
        cell?.detailTextLabel?.text = pinyin
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
}

