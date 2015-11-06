//
//  TimelineTableViewController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {

    // MARK: - Properties
    
    var posts: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTimelineForUser(UserController.sharedController.currentUser)
    }
    
    override func viewDidAppear(animated: Bool) {
        if let currentUser = UserController.sharedController.currentUser {
            if posts.count > 0 {
                // load timeline for current user
                loadTimelineForUser(currentUser)
            }
            
        } else {
            // perform segue to login/signup picker
            tabBarController?.performSegueWithIdentifier("showLoginSignupPicker", sender: nil)
        }
    }

    func loadTimelineForUser(user: User) {
        PostController.fetchTimelineForUser(user) { (posts) -> Void in
            if let posts = posts {
                self.posts = posts
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            }
        }
    }

    @IBAction func userRefreshedTable(sender: AnyObject) {
        loadTimelineForUser(UserController.sharedController.currentUser)
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postTableViewCell", forIndexPath: indexPath) as! PostTableViewCell

        let post = self.posts[indexPath.row]
        
        cell.updateWithPost(post)

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
        if segue.identifier == "toPostDetail" {
            
            let postDetailScene = segue.destinationViewController as! PostDetailTableViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let post = posts[indexPath.row]
                postDetailScene.post = post
                postDetailScene.updateBasedOnPost()
            }
        }
    }
    

}
