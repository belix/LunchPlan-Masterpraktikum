//
//  FavoritesViewController.swift
//  LunchPlan
//
//  Created by Felix Belau on 24.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FavoritesTableViewCell"

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let favorites = [MenuItem(menuName: "Currywurst", menuPrice: "1,99 €", menuImageString: "clock"),MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock"),MenuItem(menuName: "Pommes", menuPrice: "0,99 €", menuImageString: "clock")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favoriten"
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: TableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favorites.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FavoritesTableViewCell
        
        let menuItem = favorites[indexPath.row]
        // Configure the cell...
        cell.menuItemLabel.text = menuItem.menuName
        
        return cell
    }
    
    //MARK: TableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
