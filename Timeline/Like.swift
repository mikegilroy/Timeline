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
    var identifier: String?
    
    init(username: String, postID: String, identifier: String? = nil) {
        
        self.username = username
        self.postID = postID
        self.identifier = identifier
    }
}

// Equatable protocol
func == (lhs: Like, rhs: Like) -> Bool {
    return ((lhs.username == rhs.username) && (lhs.identifier == rhs.identifier))
}