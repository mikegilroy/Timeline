//
//  AddPhotoTableViewController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit

class AddPhotoTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties / Outlets
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    
    var image: UIImage?
    
    
    
    @IBAction func addPhotoButtonTapped(sender: UIButton) {
    
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        let imagePickerAlert = UIAlertController(title: "Upload photo from", message: nil, preferredStyle: .ActionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            imagePickerAlert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (cameraAction) -> Void in
                imagePicker.sourceType = .Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            imagePickerAlert.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (photoLibraryAction) -> Void in
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        presentViewController(imagePickerAlert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.image = image
        self.addPhotoButton.setBackgroundImage(image, forState: .Normal)
        self.addPhotoButton.setTitle("", forState: .Normal)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
