//
//  TableViewController.swift
//  login
//
//  Created by Byron on 2019/5/7.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var musicList : [Dictionary<String, String>] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let url = "http://zy.whu.edu.cn:8081/Api/PopMusic/list"
        let urlNet = URL(string: url)
        var request = URLRequest(url: urlNet!)
        let loginUserInfo = AppArchiver.share.read()
        //request.httpMethod = "POST"
        request.addValue(loginUserInfo!.sessionToken!, forHTTPHeaderField: "token")
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            if let nsd = data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: nsd, options: .allowFragments)
                    let result = jsonData as! Dictionary<String, Any>
                    
                    let flag = result["flag"] as! String
                    if flag == "true" {
                        
                        self.musicList = result["data"] as! [Dictionary<String,String>]
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
                catch {
                    print("JSONSerialization Error")
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return musicList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musiccell", for: indexPath)
        
        cell.textLabel?.text = musicList[indexPath.row]["title"]
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: tableViewCell)!
        let musicpath = musicList[(indexPath.row)]["url"]
        
//        let vc = segue.destination as! MusicDetailViewController
//        vc.mp3UrlPath = musicpath!
    }
}
