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
    var bio: String? = nil
    var url: String? = nil
    var userID: String
    
    init(username: String, bio: String?, url: String?, userID: String) {
        
        self.username = username
        self.bio = bio
        self.url = url
        self.userID = userID
    }
}

// Equatable protocol
func == (user1: User, user2: User) -> Bool {
    return ((user1.username == user2.username) && (user1.userID == user2.userID))
}



