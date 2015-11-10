//
//  User.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

struct User: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kBio = "bio"
    private let kUrl = "url"
    
    var username: String
    var bio: String?
    var url: String?
    var identifier: String?
    
    var endpoint: String {
        return "users"
    }
    
    var jsonValue: [String: AnyObject] {
        var json: [String: AnyObject] = [kUsername: self.username]
        
        if let bio = self.bio {
            json.updateValue(bio, forKey: kBio)
        }
        
        if let url = self.url {
            json.updateValue(url, forKey: kUrl)
        }
        
        return json
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String else { return nil }
    
        self.username = username
        
        self.bio = json[kBio] as? String
        self.url = json[kUrl] as? String
        self.identifier = identifier
    }
    
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



