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
    var identifier: String?
    
    init(username: String, text: String, postID: String, identifier: String? = nil) {
        
        self.username = username
        self.text = text
        self.postID = postID
        self.identifier = identifier
    }
}

// Equatable protocol
func == (lhs: Comment, rhs: Comment) -> Bool {
    return ((lhs.username == rhs.username) && (lhs.identifier == rhs.identifier))
}