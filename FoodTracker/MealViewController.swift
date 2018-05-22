//
//  ViewController.swift
//  FoodTracker
//
//  Created by snow on 2018/4/10.
//  Copyright © 2018年 skcc. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
    {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as?UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log:OSLog.default,type:.debug)
            return
        }
        
        
        let name = nameTextField.text ?? ""
        
        let photo = photoImageView.image
        
        let rating = ratingControl.rating
        
        
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // Disable the save button while editing.
        
        saveButton.isEnabled = false
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        updateSaveButtonState()
        
        navigationItem.title = textField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        
        //Set up views if editing an existing Meal.
        
        if let meal = meal {
            
            navigationItem.title = meal.name
            
            nameTextField.text = meal.name
            
            photoImageView.image = meal.photo
            
            ratingControl.rating = meal.rating
            
        }
        
        // Enable the save button only if the text field has a valid meal name.
        
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mealNameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        
        present(imagePickerController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following:\(info)")
        }
        photoImageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        
        if isPresentingInAddMealMode {
            
            dismiss(animated: true, completion: nil)
            
        }
        
        else if let owningNavigationController = navigationController{
            
            owningNavigationController.popViewController(animated: true)
            
        }
        
        else {
            
            fatalError("The MealVieqwController is not inside a navigation controller.")
            
        }
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    //MARK: Private Methods
    
    private func updateSaveButtonState(){
        
        //Disable the Save button if the text field is empty.
        
        let text = nameTextField.text ?? ""
        
        saveButton.isEnabled = !text.isEmpty
        
    }

}


