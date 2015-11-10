//
//  ImageController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static let mockImageIdentifier = "-K1l4125TYvKMc7rcp5e"
    
    
//    Add a static function uploadImage that takes an image and completion closure with an identifier String parameter
//    note: We use an identifier for the image instead of a URL because we are uploading to Firebase. If we were uploading to Amazon S3 or other cloud service, we would probably return a URL instead of identifier.
    
    static func uploadImage(image: UIImage, completion: (identifier: String?) -> Void) {
        completion(identifier: mockImageIdentifier)
    }

    
    static func imageForIdentifier(identifier: String, completion: (image: UIImage?) -> Void) {
        completion(image: UIImage(named: "MockPhoto"))
    }
    
}