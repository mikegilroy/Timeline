//
//  Post.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

struct Post: Equatable, FirebaseType {
    
    private let kImageEndpoint = "imageEndpoint"
    private let kCaption = "caption"
    private let kUsername = "username"
    private let kComments = "comments"
    private let kLikes = "likes"
    
    var imageEndPoint: String
    var caption: String? = nil
    var username: String
    var comments: [Comment] = []
    var likes: [Like] = []
    var identifier: String?
    
    var endpoint: String {
        return "/posts/\(self.identifier)"
    }
    
    var jsonValue: [String: AnyObject] {
        
        var json: [String: AnyObject] = [kUsername: self.username, kImageEndpoint: self.imageEndPoint, kComments : self.comments.map({$0.jsonValue}), kLikes: self.likes.map({$0.jsonValue})]
        
        if let caption = self.caption {
            json.updateValue(caption, forKey: self.kCaption)
        }
        
        return json
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        
        guard let imageEndPoint = json[kImageEndpoint] as? String,
            let username = json[kUsername] as? String else { return nil }
        
        self.username = username
        self.imageEndPoint = imageEndPoint
        self.caption = json[kCaption] as? String
        
        if let commentDictionaries = json[kComments] as? [String: AnyObject] {
            self.comments = commentDictionaries.flatMap({Comment(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
        } else {
            self.comments = []
        }
        
        if let likeDictionaries = json[kLikes] as? [String: AnyObject] {
            self.likes = likeDictionaries.flatMap({Like(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
        } else {
            self.likes = []
        }
    }
    
    
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