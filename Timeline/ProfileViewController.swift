//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController, UICollectionViewDataSource, ProfileHeaderCollectionReusableViewDelegate {
    
    // MARK: Properties/OUtlets
    
    var user: User?
    var userPosts: [Post] = []
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    // MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        print(user)
        
        if user == nil {
            self.user = UserController.sharedController.currentUser
        }
        updateBasedOnUser()
    }


    func updateBasedOnUser() {
        if let user = user {
            title = user.username
            PostController.postsForUser(user) { (posts) -> Void in
                if let posts = posts {
                    self.userPosts = posts
                } else {
                    self.userPosts = []
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.imageCollectionView.reloadData()
                })
            }
        }
    }
    
    
    
    // MARK: CollectionView Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        let currentPost = self.userPosts[indexPath.row]
        
        cell.updateWithImageIdentifier(currentPost.imageEndPoint)
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let supplementaryView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "profileHeader", forIndexPath: indexPath) as! ProfileHeaderCollectionReusableView
        
        supplementaryView.updateWithUser(user!)
        supplementaryView.delegate = self
        
        return supplementaryView
    }
    
    
    // MARK: ProfileHeaderCollectionReusableView Delegate
    
    
    func userTappedURLButton() {
        
        if let profileURL = NSURL(string: self.user!.url!) {
            let safariViewController = SFSafariViewController(URL: profileURL)
            
            presentViewController(safariViewController, animated: true, completion: nil)
        }
    }
    
    
    func userTappedFollowActionButton() {
        guard let user = user else { return }
        
        if user == UserController.sharedController.currentUser {
            
            UserController.logOutCurrentUser()
            tabBarController?.selectedViewController = tabBarController?.viewControllers![0]
        }
        
        UserController.userFollowsUser(UserController.sharedController.currentUser, user2: self.user!) { (follows) -> Void in
            if follows {
                UserController.unfollowUser(self.user!, completion: { (success) -> Void in
                    if success {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    }
                })
            } else {
                UserController.followUser(self.user!, completion: { (success) -> Void in
                    if success {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    }
                })
            }
        }
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
