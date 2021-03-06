//
//  MemeEditorViewController.swift
//  MemeMePractice
//
//  Created by Gabriele on 3/19/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    var memedImage: UIImage!
    
    // Dictionary to hold text attributes
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -4.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.enabled = false
        
        setUpText(topText, text: "TOP")
        setUpText(bottomText, text: "BOTTOM")
    }
    
    
    // Sets text, text attributes, text alignment, and delegate to self for both text fields
    func setUpText(textField: UITextField, text: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = text
        textField.textAlignment = .Center
        textField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func clearMeme(sender: AnyObject) {
        // Clear meme image and text fields and return to Sent Memes
        imagePickerView.image = nil
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Presents Image Picker to user
    @IBAction func pickAnImage(sender: AnyObject) {
        presentImagePickerController(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    // Allows user to pick image from camera
    @IBAction func pickFromCamera(sender: UIBarButtonItem) {
        presentImagePickerController(UIImagePickerControllerSourceType.Camera)
    }
    
    // Creates a UiImagePickerController, sets the delegate to self, sets sourcetype, and presents imagePicker
    func presentImagePickerController(source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    // Sets the picked image to be in the Image View
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        
        shareButton.enabled = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Generate the memed image
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        navbar.hidden = true
        toolbar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navbar.hidden = false
        toolbar.hidden = false
        
        return memedImage
    }
    
   func save() {
        let meme = Meme(topText: topText.text!, bottomtext: bottomText.text!, image: imagePickerView.image!, memedImage: memedImage!)
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    // Clears placeholder text from screen when user taps inside a textfield
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
        
        // Checks top and bottom text to see if it's been changed
        if textField.text != "TOP" || textField.text != "BOTTOM" {
            textField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Allows user to share meme to social media, send via email, etc
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(controller, animated: true, completion: nil)
    }
    
    // Moves the view when keyboard covers text field
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomText.isFirstResponder() {
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Hiding keyboard
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

