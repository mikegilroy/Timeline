//
//  ProfileHeaderCollectionReusableView.swift
//  Timeline
//
//  Created by Mike Gilroy on 04/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate {
    func userTappedFollowActionButton()
    func userTappedURLButton()
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: Properties / Outlets
    
    @IBOutlet weak var biolLabel: UILabel!
    @IBOutlet weak var homepageButton: UIButton!
    @IBOutlet weak var followUserButton: UIButton!
    
    var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    
    // MARK: Actions
    
    @IBAction func urlButtonTapped(sender: AnyObject) {
        self.delegate?.userTappedURLButton()
    }
    
    @IBAction func followActionButtonTapped(sender: AnyObject) {
        self.delegate?.userTappedFollowActionButton()
    }
    
    
    
    // MARK: Functions
    
    func updateWithUser(user: User) {
        
        if let bio = user.bio {
            self.biolLabel.text = bio
        } else {
            biolLabel.hidden = true
        }
        
        if let url = user.url {
            self.homepageButton.setTitle("\(url)", forState: .Normal)
        } else {
            self.homepageButton.hidden = true
        }
        
        if user == UserController.sharedController.currentUser {
            followUserButton.hidden = true
        } else {
            UserController.userFollowsUser(UserController.sharedController.currentUser, user2: user, completion: { (follows) -> Void in
                if follows {
                    self.followUserButton.setTitle("Unfollow", forState: .Normal)
                } else {
                    self.followUserButton.setTitle("Follow", forState: .Normal)
                }
            })
        }
    }
    
    
}
