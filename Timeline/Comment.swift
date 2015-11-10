//
//  Comment.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

struct Comment: Equatable, FirebaseType {
    
    private let kPostID = "post"
    private let kUsername = "username"
    private let kText = "text"
    
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
    
    
    var endpoint: String {
            return "/posts/\(self.postID)/comments/"
    }
    
    var jsonValue: [String: AnyObject] {
            return [ kPostID : self.postID, kText : self.text, kUsername : self.username ]
    }
    
    init?(json: [String: AnyObject], identifier: String) {
        
        guard let username = json[kUsername] as? String,
            let text = json[kText] as? String,
            let postID = json[kPostID] as? String else {
                self.username = ""
                self.postID = ""
                self.text = ""
                return
        }
        
        self.username = username
        self.postID = postID
        self.text = text
        self.identifier = identifier
    }
    
}

// Equatable protocol
func == (lhs: Comment, rhs: Comment) -> Bool {
    return ((lhs.username == rhs.username) && (lhs.identifier == rhs.identifier))
}