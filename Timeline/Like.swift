//
//  Like.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

struct Like: Equatable, FirebaseType {
    
    private let kUsername =  "username"
    private let kPostID = "postID"
    
    var username: String
    var postID: String
    var identifier: String?
    
    init(username: String, postID: String, identifier: String? = nil) {
        
        self.username = username
        self.postID = postID
        self.identifier = identifier
    }
    
    var jsonValue: [String: AnyObject]? {
        return [ kPostID: self.postID, kUsername: self.username ]
    }
    
    var endpoint: String {
            return "/posts/\(self.postID)/likes/"
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String,
            let postID = json[kPostID] as? String else { return nil }
        
        self.postID = postID
        self.username = username
        self.identifier = identifier
    }
    
    
}

// Equatable protocol
func == (lhs: Like, rhs: Like) -> Bool {
    return ((lhs.username == rhs.username) && (lhs.identifier == rhs.identifier))
}