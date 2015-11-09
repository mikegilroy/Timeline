//
//  Comment.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

struct Comment: Equatable, FirebaseType {
    
    private let postKey = "post"
    private let usernameKey = "username"
    private let textKey = "text"
    
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
        get {
            return "/posts/\(self.postID)/comments/"
        }
    }
    
    var jsonValue: [String: AnyObject]? {
        get {
            return [
                postKey : self.postID,
                textKey : self.text,
                usernameKey : self.username
                ]
        }
    }
    
    init?(json: [String: AnyObject], identifier: String) {
        
        guard let username = json[usernameKey] as? String,
            let text = json[textKey] as? String,
            let postID = json[postKey] as? String else {
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