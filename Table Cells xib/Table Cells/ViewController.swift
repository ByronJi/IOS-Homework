//
//  ViewController.swift
//  Table Cells
//
//  Created by Byron on 2019/3/30.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource{
    
    let cellID = "CellID"
    @IBOutlet weak var tableView: UITableView!
    let computers = [["Name" : "Macbook Air", "Color" : "Silver"],["Name" : "Macbook Pro", "Color" : "Silver"],["Name" : "iMac", "Color" : "Silver"],["Name" : "MacMini", "Color" : "Silver"],["Name" : "Macbook Pro", "Color" : "Black"]]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return computers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! NameAndColorCellTableViewCell
        let rowData = computers[indexPath.row]
        cell.name = rowData["Name"]!
        cell.color = rowData["Color"]!
        
        return cell
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NameAndColorCellTableViewCell.self, forCellReuseIdentifier: cellID)
        
        let xib = UINib(nibName: "NameAndColorCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 65
    }


}

