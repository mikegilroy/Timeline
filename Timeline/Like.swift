//
//  Like.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

struct Like: Equatable {
    
    var username: String
    var postID: String
    var likeID: String
    
    init(username: String, postID: String, likeID: String) {
        
        self.username = username
        self.postID = postID
        self.likeID = likeID
    }
}

// Equatable protocol
func == (lhs: Like, rhs: Like) -> Bool {
    return ((lhs.username == rhs.username) && (lhs.likeID == rhs.likeID))
}