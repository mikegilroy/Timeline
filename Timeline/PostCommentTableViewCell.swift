//
//  PostCommentTableViewCell.swift
//  Timeline
//
//  Created by Mike Gilroy on 05/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit

class PostCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateWithComment(comment: Comment) {
        self.usernameLabel.text = comment.username
        self.commentLabel.text = comment.text
    }

}
