//
//  Comment.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

struct Comment: Equatable {
    
    var username: String
    var text: String
    var postID: String
    var commentID: String
    
    init(username: String, text: String, postID: String, commentID: String) {
        
        self.username = username
        self.text = text
        self.postID = postID
        self.commentID = commentID
    }
}

// Equatable protocol
func == (lhs: Comment, rhs: Comment) -> Bool {
    return ((lhs.username == rhs.username) && (lhs.commentID == rhs.commentID))
}