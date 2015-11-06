//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {

    // MARK: Properties/Outlets
    
    @IBOutlet weak var headerImageView: UIImageView!

    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!

    
    var post: Post?
    
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateBasedOnPost() {
            ImageController.imageForIdentifier(post!.imageEndPoint, completion: { (image) -> Void in
                if let image = image {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.headerImageView.image = image
                        if let post = self.post {
                            self.likesLabel.text = " likes"
                            self.commentsLabel.text = " comments"
                        }
                    })
                }
            })
        
        tableView.reloadData()
    }

    
    // MARK: Actions
    
    @IBAction func likeButtonTapped(sender: AnyObject) {
        PostController.addLikeToPost(post!) { (success, post) -> Void in
            
            if let post = post {
                self.post = post
                self.updateBasedOnPost()
            }
        }
    }
    
    @IBAction func addCommentTapped(sender: AnyObject) {
        let alert = UIAlertController(title: "Add comment", message: nil, preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Comment"
        }
        
        alert.addAction(UIAlertAction(title: "Add comment", style: .Default, handler: { (addComment) -> Void in
            
            if let text = alert.textFields?.first?.text {
                
                PostController.addCommentWithTextToPost(text, post: self.post!, completion: { (success, post) -> Void in
                    if let post = post {
                        self.post = post
                        self.updateBasedOnPost()
                    }
                })
            }
        }))
            
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (post!.comments.count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! PostCommentTableViewCell

        let comment = post?.comments[indexPath.row]
        
        cell.updateWithComment(comment!)
        // Configure the cell...

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
