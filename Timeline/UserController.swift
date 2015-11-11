//
//  UserController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

class UserController {
    
    private let userKey = "user"
    
    static let sharedController = UserController()
    
    var currentUser: User! {
        get {
            
            guard let uid = FirebaseController.base.authData?.uid,
                let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(userKey) as? [String: AnyObject] else {
                    
                    return nil
            }
            
            return User(json: userDictionary, identifier: uid)
        }
        
        set {
            
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: userKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(userKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        FirebaseController.dataAtEndpoint("users/\(identifier)") { (data) -> Void in
            if let data = data as? [String:AnyObject] {
                
                let user = User(json: data, identifier: identifier)
                completion(user: user)
                
            } else {
                completion(user: nil)
            }
        }
        
    }
  
//    6. Define a static function `fetchAllUsers` that takes a completion closure with an array of User parameter.
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        FirebaseController.dataAtEndpoint("users") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let users = data.flatMap({User(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
                completion(users: users)
            } else {
                completion(users: [])
            }
        }
    }
    
    
//    7. Define a static function `followUser` that takes a user and completion closure with a success Boolean parameter.
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        FirebaseController.base.childByAppendingPath("/users/\(sharedController.currentUser.identifier!)/follows/\(user.identifier!)").setValue(true)
        
        completion(success: true)
        
    }
    
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        
        FirebaseController.base.childByAppendingPath("/users/\(sharedController.currentUser.identifier!)/follows/\(user.identifier!)").removeValue()
        
        completion(success: true)
    }
    
//    8. Define a static function `userFollowsUser` that takes a user, and a user to check against, and a completion closure with a follows Boolean parameter.
    
    static func userFollowsUser(user: User, followsUser: User, completion: (follows: Bool) -> Void) {
      
        FirebaseController.dataAtEndpoint("/users/\(user.identifier!)/follows/\(followsUser.identifier!)") { (data) -> Void in
            if let _ = data {
                completion(follows: true)
            } else {
                completion(follows: false)
            }
        }
        
    }
    
    
//    9. Define a static function `followedByUser` that takes a user and completion closure with an optional array of Users parameter.
    
    static func followedByUser(user: User, completion: (users: [User]?) -> Void) {
        
        FirebaseController.dataAtEndpoint("/users/\(user.identifier!)/follows/") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                
                var users: [User] = []
                
                for userJson in data {
                    
                    userForIdentifier(userJson.0, completion: { (user) -> Void in
                        if let user = user {
                            users.append(user)
                            
                        }
                    })
                }
                completion(users: users)
            
            } else {
                completion(users: [])
            }
        }
    }
    
    
//    10. Define a static function `authenticateUser` that takes an email, password, and completion closure with a success Boolean parameter and optional User parameter.
//    * note: Will be used to authenticate against our Firebase database of users.

    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        
        FirebaseController.base.authUser(email, password: password) { (error, authData) -> Void in
            if error != nil {
                completion(success: false, user: nil)
            } else {
                
                let userID = authData.uid
                
                UserController.userForIdentifier(userID, completion: { (user) -> Void in
                    if let user = user {
                        sharedController.currentUser = user
                    }
                    
                    completion(success: true, user: user)
                })
            }
        }
    }
    
    
//    11. Define a static function `createUser` that takes an email, username, password, optional bio, optional url, and completion closure with a success Boolean parameter and optional User parameter.
//    * note: Will be used to create a user in Firebase.
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
       
        FirebaseController.base.createUser(email, password: password) { (error, response) -> Void in
            if let uid = response["uid"] as? String {
                var user = User(username: username, bio: bio, url: url, identifier: uid)
                user.save()
                
                authenticateUser(email, password: password, completion: { (success, user) -> Void in
                        completion(success: true, user: user)
                })
                
            } else {
                completion(success: false, user: nil)
            }
        }
    }
    
    
//    12. Define a static function `updateUser` that takes a user, username, optional bio, optional url, and completion closure with a success Boolean parameter and optional User parameter.
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
        var user = User(username: username, bio: bio, url: url, identifier: user.identifier!)
        user.save()
        
        userForIdentifier(user.identifier!) { (user) -> Void in
            if let user = user {
                UserController.sharedController.currentUser = user
                completion(success: true, user: user)
            } else {
                completion(success: false, user: nil)
            }
        }
    }
    
    
//    13. Define a static function `logOutCurrentUser` that takes no parameters.
    
    static func logOutCurrentUser() {
        FirebaseController.base.unauth()
        UserController.sharedController.currentUser = nil
    }
    
    
    
//    14. Define a static function `mockUsers()` that returns an array of sample users.
//    15. Implement the `mockUsers()` function by returning an array of at least 3 initialized users
    
    static func mockUsers() -> [User] {
        
        let user1 = User(username: "mikegilroy", bio: "Londoner", url: "http://twitter.com/mike_gilroy", identifier: "0001")
        let user2 = User(username: "mediarob", bio: "So media", url: nil, identifier: "0002")
        let user3 = User(username: "instaTweed", bio: "I'm so edgey", url: "http://instagram.com/instatweed", identifier: "0003")
        let user4 = User(username: "curreel", bio: "Where are the horses at?", url: nil, identifier: "0004")
        let user5 = User(username: "charlesrose", bio: "BRB: At lunch", url: nil, identifier: "0005")
        let user6 = User(username: "gilroyben", bio: "Climbing mountains", url: "http://twitter.com/gilroyben", identifier: "0006")
        
        return [user1, user2, user3, user4, user5, user6]
    }
    

    
    
    
//    16. Use the `mockUsers()` function to implement staged completion closures in the rest of your static functions with completion closures.
//    17. Update the initialization of the `currentUser` to the result of the first mock user.

    
}