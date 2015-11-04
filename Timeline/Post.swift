//
//  Post.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

struct Post: Equatable {
    
    var imageEndPoint: String
    var caption: String? = nil
    var username: String
    var comments: [Comment] = []
    var likes: [Like] = []
    var identifier: String?
    
    init(imageEndPoint: String, caption: String? = nil, username: String, comments: [Comment], likes: [Like], identifier: String? = nil) {
     
        self.imageEndPoint = imageEndPoint
        self.caption = caption
        self.username = username
        self.comments = comments
        self.likes = likes
        self.identifier = identifier
    }
}

// Equatable protocol
func == (lhs: Post, rhs: Post) -> Bool {
    return ((lhs.username == rhs.username) && (lhs.identifier == rhs.identifier))
}