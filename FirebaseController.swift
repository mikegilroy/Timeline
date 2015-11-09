//
//  FirebaseController.swift
//  Timeline
//
//  Created by Mike Gilroy on 09/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let base = Firebase(url: "https://instatweed.firebaseio.com/")
    
    static func dataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        
        let ref = base.childByAppendingPath(endpoint)
        ref.observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if snapshot.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snapshot.value)
            }
        })
    }
    
    
    static func observeDataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let ref = base.childByAppendingPath(endpoint)
        ref.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            if snapshot.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snapshot.value)
            }
        })
    }
    
}


protocol FirebaseType {
    var identifier: [String]? { get set }
    
    var endpoint: String { get }
    
    var jsonValue: [String: AnyObject]? { get }
    
    init?(json: [String: AnyObject], identifier: String)
    
    mutating func save()
    
    func delete()
}