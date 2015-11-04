//
//  User.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

struct User: Equatable {
    
    var username: String
    var bio: String?
    var url: String?
    var identifier: String?
    
    init(username: String, bio: String? = nil, url: String? = nil, identifier: String) {
        
        self.username = username
        self.bio = bio
        self.url = url
        self.identifier = identifier
    }
}

// Equatable protocol
func == (user1: User, user2: User) -> Bool {
    return ((user1.username == user2.username) && (user1.identifier == user2.identifier))
}



