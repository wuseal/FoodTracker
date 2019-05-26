//
//  MealViewController.swift
//  FoodTracker
//
//  Created by 吴海豹 on 2019/1/26.
//  Copyright © 2019 吴海豹. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    /*
        This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
        or constructed as part of adding a new meal.
     */
    var meal: Meal?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Handle the text field user input through the delegate callbacks
        nameTextField.delegate = self

        updateSaveButtonState()
    }

    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating

        meal = Meal(name: name, photo: photo, rating: rating)
    }

    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

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


    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

