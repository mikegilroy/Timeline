//
//  ImageCollectionViewCell.swift
//  Timeline
//
//  Created by Mike Gilroy on 04/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    func updateWithImageIdentifier(identifier: String) {
        ImageController.imageForIdentifier(identifier) { (image) -> Void in
            if let image = image {
                self.imageView.image = image
            } else {
                print("No image found for identifier")
            }
        }
    }


}

