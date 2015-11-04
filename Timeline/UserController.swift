//
//  UserController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation

class UserController {
    
    static let sharedController = UserController()
    
    var currentUser: User! = UserController.mockUsers().first
    
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        completion(user: mockUsers().first)
    }
  
//    6. Define a static function `fetchAllUsers` that takes a completion closure with an array of User parameter.
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        completion(users: mockUsers())
    }
    
    
//    7. Define a static function `followUser` that takes a user and completion closure with a success Boolean parameter.
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        completion(success: true)
    }
    
    
//    8. Define a static function `userFollowsUser` that takes a user, and a user to check against, and a completion closure with a follows Boolean parameter.
    
    static func userFollowsUser(user1: User, user2: User, completion: (follows: Bool) -> Void) {
       completion(follows: true)
    }
    
    
//    9. Define a static function `followedByUser` that takes a user and completion closure with an optional array of Users parameter.
    
    static func followedByUser(user: User, completion: (users: [User]?) -> Void) {
        completion(users: mockUsers())
    }
    
    
//    10. Define a static function `authenticateUser` that takes an email, password, and completion closure with a success Boolean parameter and optional User parameter.
//    * note: Will be used to authenticate against our Firebase database of users.

    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().first)
    }
    
    
//    11. Define a static function `createUser` that takes an email, username, password, optional bio, optional url, and completion closure with a success Boolean parameter and optional User parameter.
//    * note: Will be used to create a user in Firebase.
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().first)
    }
    
    
//    12. Define a static function `updateUser` that takes a user, username, optional bio, optional url, and completion closure with a success Boolean parameter and optional User parameter.
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().first)
    }
    
    
//    13. Define a static function `logOutCurrentUser` that takes no parameters.
    
    static func logOutCurrentUser() {
        
    }
    
    
//    14. Define a static function `mockUsers()` that returns an array of sample users.
//    15. Implement the `mockUsers()` function by returning an array of at least 3 initialized users
    
    static func mockUsers() -> [User] {
        
        let user1 = User(username: "mikegilroy", bio: "Londoner", url: "http://twitter.com/mike_gilroy", userID: "0001")
        let user2 = User(username: "mediarob", bio: "So media", url: nil, userID: "0002")
        let user3 = User(username: "instaTweed", bio: "I'm so edgey", url: "http://instagram.com/instatweed", userID: "0003")
        let user4 = User(username: "curreel", bio: "Where are the horses at?", url: nil, userID: "0004")
        let user5 = User(username: "charlesrose", bio: "BRB: At lunch", url: nil, userID: "0005")
        let user6 = User(username: "gilroyben", bio: "Climbing mountains", url: "http://twitter.com/gilroyben", userID: "0006")
        
        return [user1, user2, user3, user4, user5, user6]
    }
    

    
    
    
//    16. Use the `mockUsers()` function to implement staged completion closures in the rest of your static functions with completion closures.
//    17. Update the initialization of the `currentUser` to the result of the first mock user.

    
}