//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Mike Gilroy on 05/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: Properties/Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateWithPost(post: Post) {
        self.likesLabel.text = "\(post.likes.count) likes"
        self.commentsLabel.text = "\(post.comments.count) comments"
        
        ImageController.imageForIdentifier(post.imageEndPoint) { (image) -> Void in
            if let image = image {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.postImageView.image = image
                })
            }
        }
    }

}
