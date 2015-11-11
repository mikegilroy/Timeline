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
        UserController.followedByUser(user) { (users) -> Void in
            var allPosts: [Post] = []
            
            let group = dispatch_group_create()
            
            dispatch_group_enter(group)
            PostController.postsForUser(UserController.sharedController.currentUser, completion: { (posts) -> Void in
                if let posts = posts {
                        allPosts += posts
                }
                dispatch_group_leave(group)
            })
            
            
            if let users = users {
                for user in users {
                    dispatch_group_enter(group)
                    PostController.postsForUser(user, completion: { (posts) -> Void in
                        if let posts = posts {
                               allPosts += posts
                        }
                        dispatch_group_leave(group)
                    })
                }
            }
            dispatch_group_notify(group, dispatch_get_main_queue(), { () -> Void in
                let orderedPosts = orderPosts(allPosts)
                completion(posts: orderedPosts)
            })
        }
    }
    
    
//    Add a static function addPost that takes an image, optional caption, and completion closure with a success Boolean parameter and optional Post parameter
    
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        ImageController.uploadImage(image) { (identifier) -> Void in
            
            if let identifier = identifier {
                var post = Post(imageEndPoint: identifier, caption: caption, username: UserController.sharedController.currentUser.username)
                post.save()
                completion(success: true, post: post)
            } else {
                completion(success: false, post: nil)
            }
            
        }
        
        completion(success: true, post: mockPosts().first)
    }
    
//    Add a static function postFromIdentifier that takes an identifier and completion closure with optional Post parameter
    
    static func postFromIndentifier(identifier: String, completion: (post: Post?) -> Void) {
        FirebaseController.dataAtEndpoint("posts/\(identifier)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let post = Post(json: data, identifier: identifier)
                completion(post: post)
            } else {
                completion(post: nil)
            }
        }
    }
    
    
//    Add a static function postsForUser that takes a User and completion closure with optional array of Post objects parameter
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("username").queryEqualToValue(user.username).observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if let postDictionaries = snapshot.value as? [String: AnyObject] {
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                
                let orderedPosts = orderPosts(posts)
                completion(posts: orderedPosts)
            } else {
                completion(posts: nil)
            }
        })
    }
    
    
//    Add a static function deletePost that takes a Post and completion closure with a success Boolean parameter
    
    static func deletePost(post: Post, completion: (success: Bool) -> Void) {
        post.delete()
    }
    
    
//    Add a static function addCommentWithTextToPost that takes a String, Post, and completion closure with a success Boolean parameter and optional Post parameter
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
       
        if let postID = post.identifier {
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postID: postID)
            comment.save()
            
            PostController.postFromIndentifier(comment.postID, completion: { (post) -> Void in
                completion(success: true, post: post)
            })
        } else {
            var post = post
            post.save()
            
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postID: post.identifier!)
            comment.save()
            
            PostController.postFromIndentifier(comment.postID, completion: { (post) -> Void in
                completion(success: true, post: post)
            })
        }
    }
    
    
//    Add a static function deleteComment that takes a Comment and completion closure with a success Boolean parameter and optional Post parameter
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        comment.delete()
        
        postFromIndentifier(comment.postID) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    
//    Add a static function addLikeToPost that takes a Post, and completion closure with a success Boolean parameter and optional Post parameter
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
        if let postID = post.identifier {
            var like = Like(username: UserController.sharedController.currentUser.username, postID: postID)
            like.save()
            
        } else {
            var post = post
            post.save()
            
            var like = Like(username: UserController.sharedController.currentUser.username, postID: post.identifier!)
            like.save()
        }
        
        PostController.postFromIndentifier(post.identifier!, completion: { (post) -> Void in
            completion(success: true, post: post)
        })
    }
    
//    Add a static function deleteLike that takes a Like and completion closure with a success Boolean parameter and optional Post parameter
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        
        like.delete()
        
        postFromIndentifier(like.postID) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    
//    Add a static function orderPosts that takes an array of Post objects and returns a sorted array of Post objects
    
    static func orderPosts(posts: [Post]) -> [Post] {
        return posts.sort({$0.identifier > $1.identifier})
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