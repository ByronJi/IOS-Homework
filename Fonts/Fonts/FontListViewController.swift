//
//  FontListViewController.swift
//  Fonts
//
//  Created by Byron on 2019/4/6.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {

    var fontNames:[String] = []
    var showFavorites:Bool = false
    private var cellPointSize:CGFloat!
    private static let cellID = "FontName"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
        
        if showFavorites{
            navigationItem.rightBarButtonItem = editButtonItem
        }
    }

    func fontForDisplay(atIndexPath indexPath:NSIndexPath) -> UIFont?{
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if showFavorites{
            fontNames = FavoritesList.sharedFavoritesList.favorites
            tableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: tableViewCell)
        let font = fontForDisplay(atIndexPath: indexPath! as NSIndexPath)
        
        if segue.identifier == "ShowFontSizes"{
            let sizesVC = segue.destination as! FontSizesViewController
            sizesVC.title = font?.fontName
            sizesVC.font = font
        } else {
            let infoVC = segue.destination as! FontInfoViewController
            infoVC.title = font?.fontName
            infoVC.font = font
            infoVC.favorite = FavoritesList.sharedFavoritesList.favorites.contains(font!.fontName)
        }
        
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        FavoritesList.sharedFavoritesList.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        fontNames = FavoritesList.sharedFavoritesList.favorites
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return showFavorites
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if !showFavorites
        {
            return
        }
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let favorite = fontNames[indexPath.row]
            FavoritesList.sharedFavoritesList.removeFavorite(fontName: favorite)
            fontNames = FavoritesList.sharedFavoritesList.favorites
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fontNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FontListViewController.cellID, for: indexPath)
        
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        return cell
    }

}
