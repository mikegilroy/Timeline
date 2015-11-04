//
//  PostController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    static let imageIdentifier = "-K1l4125TYvKMc7rcp5e"
    
    
//    Add a static function fetchTimelineForUser that takes a user and completion closure with an array of Posts parameter
    
    static func fetchTimelineForUser(user: User, completion: (posts: [Post]?) -> Void) {
        completion(posts: mockPosts())
    }
    
    
//    Add a static function addPost that takes an image, optional caption, and completion closure with a success Boolean parameter and optional Post parameter
    
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
//    Add a static function postFromIdentifier that takes an identifier and completion closure with optional Post parameter
    
    static func postFromIndentifier(indetifier: String, completion: (post: Post?) -> Void) {
        completion(post: mockPosts().first)
    }
    
    
//    Add a static function postsForUser that takes a User and completion closure with optional array of Post objects parameter
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        completion(posts: mockPosts())
    }
    
    
//    Add a static function deletePost that takes a Post and completion closure with a success Boolean parameter
    
    static func deletePost(post: Post, completion: (success: Bool) -> Void) {
        completion(success: true)
    }
    
    
//    Add a static function addCommentWithTextToPost that takes a String, Post, and completion closure with a success Boolean parameter and optional Post parameter
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    
//    Add a static function deleteComment that takes a Comment and completion closure with a success Boolean parameter and optional Post parameter
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    
//    Add a static function addLikeToPost that takes a Post, and completion closure with a success Boolean parameter and optional Post parameter
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
//    Add a static function deleteLike that takes a Like and completion closure with a success Boolean parameter and optional Post parameter
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    
//    Add a static function orderPosts that takes an array of Post objects and returns a sorted array of Post objects
    
    static func orderPosts(posts: [Post]) -> [Post] {
        return []
    }
    
    
//    Add a static function mockPosts() function that returns an array of sample posts
    
    static func mockPosts() -> [Post] {
        
        let like1 = Like(username: "mikegilroy", postID: "0002", identifier: "0001")
        let like2 = Like(username: "gilroyben", postID: "0001", identifier: "0002")
        let like3 = Like(username: "instatweed", postID: "0003", identifier: "0003")
        
        let comment1 = Comment(username: "curreel", text: "You are so media", postID: "0002", identifier: "0001")
        let comment2 = Comment(username: "mediarob", text: "Nice shirt Charles", postID: "0004", identifier: "0002")
        let comment3 = Comment(username: "charlesrose", text: "It's no lunch though", postID: "0002", identifier: "0003")
        
        let post1 = Post(imageEndPoint: imageIdentifier, caption: "Love this place", username: "mikegilroy", comments: [], likes: [like2], identifier: "0001")
        let post2 = Post(imageEndPoint: imageIdentifier, caption: "I love media", username: "mediarob", comments: [comment1, comment3], likes: [like1], identifier: "0002")
        let post3 = Post(imageEndPoint: imageIdentifier, caption: "#nofilter", username: "instatweed", comments: [], likes: [like3], identifier: "0003")
        let post4 = Post(imageEndPoint: imageIdentifier, caption: "At lunch again", username: "charlesrose", comments: [comment2], likes: [], identifier: "0004")
        
        return [post1, post2, post3, post4]
    }
    
    
//    Implement the mockPosts() function by returning an array of at least 3 initalized posts
//    note: Use a static string -K1l4125TYvKMc7rcp5e as the sample image identifier
    
//    Use the mockPosts() function to implement staged completion closures in the rest of your static functions

    
    
}