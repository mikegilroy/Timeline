//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // MARK: Properties/Outlets
    
    var usersDataSource: [User] = []
    var mode: ViewMode {
        get {
            return ViewMode(rawValue: self.modeSegmentedControl.selectedSegmentIndex)!
        }
    }
    
    enum ViewMode: Int {
        case Friends = 0
        case All = 1
        
        func users(completion: (users: [User]?) -> Void) {
            
            switch self {
            case .Friends:
                UserController.followedByUser(UserController.sharedController.currentUser, completion: { (users) -> Void in
                    completion(users: users)
                })
            case .All:
                UserController.fetchAllUsers({ (users) -> Void in
                    completion(users: users)
                })
            }
        }
    }
    
    
    var searchController: UISearchController!
    
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    
    
    // MARK: Actions
    
    @IBAction func modeSegmentedControlValueChanged(sender: UISegmentedControl) {
        updateViewBasedOnMode()
    }
    
    
    
    
    // MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode()
        setupSearchController()
    }

    
    func updateViewBasedOnMode() {
        mode.users { (users) -> Void in
            if let users = users {
                self.usersDataSource = users
                self.tableView.reloadData()
            } else {
               print("No users found")
            }
        }
    }
    
    
    func setupSearchController() {
        
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SearchResultsController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text!.lowercaseString
        
        let resultsController = searchController.searchResultsController as? UserSearchResultsTableViewController
        
        if let resultsController = resultsController {
            resultsController.userResultsDataSource = usersDataSource.filter({$0.username.lowercaseString.containsString(searchTerm)})
            resultsController.tableView.reloadData()
        }

    }
 
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersDataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
        
        let currentUser = self.usersDataSource[indexPath.row]
        cell.textLabel?.text = currentUser.username
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toProfileView" {
            if let sender = sender as? UITableViewCell {
                if let indexPath = self.tableView.indexPathForCell(sender) {
                    let selectedUser = usersDataSource[indexPath.row]
                    let profileScene = segue.destinationViewController as? ProfileViewController
                    profileScene?.user = selectedUser
                    
                } else {
                    let searchResultsController = searchController.searchResultsController as! UserSearchResultsTableViewController
                    if let indexPath = searchResultsController.tableView.indexPathForCell(sender) {
                        let selectedUser = searchResultsController.userResultsDataSource[indexPath.row]
                        let profileScene = segue.destinationViewController as? ProfileViewController
                        profileScene?.user = selectedUser
                    }
                }
            }
        }
    }

}
