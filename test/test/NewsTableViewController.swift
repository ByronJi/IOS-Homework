//
//  NewsTableViewController.swift
//  test
//
//  Created by Byron on 2019/4/26.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var newsList:[Dictionary<String,String>]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let url = URL(string: "http://zy.whu.edu.cn:8081/api/try/newsList")
        do{
            let nsdata = try Data(contentsOf: url!)
            let jsondata = try JSONSerialization.jsonObject(with: nsdata, options: .allowFragments)
            print(jsondata)
            newsList = (jsondata as! NSDictionary).value(forKey: "data") as? [Dictionary<String,String>]
            print(newsList)
        }catch{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let xib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        
        tableView.register(xib, forCellReuseIdentifier: "NewsCell")
        tableView.rowHeight = 130
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        cell.NewsTitle?.text = newsList![indexPath.row]["title"]
        cell.NewsDate?.text = newsList![indexPath.row]["updateTime"]
        let imageUrl = newsList![indexPath.row]["picURL"]
        cell.NewsImage?.loadFromNet(imageUrl:imageUrl!)
        return cell
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
