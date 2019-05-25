//
//  ViewController.swift
//  FoodTracker
//
//  Created by 吴海豹 on 2019/1/26.
//  Copyright © 2019 吴海豹. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field user input through the delegate callbacks
        nameTextField.delegate = self
        myLabel.text = "I am Seal's"
    }

    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
             fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
         // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        //dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    //MARK: UITextFieldDelegate
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that let a user pick media from their photo library
        let imagePickController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken
        imagePickController.sourceType = .photoLibrary
        
        //make sure ViewController is notified when the user picked a picture
        imagePickController.delegate = self
        
        present(imagePickController, animated: true, completion: nil)
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
}

