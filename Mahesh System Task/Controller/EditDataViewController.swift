//
//  EditDataViewController.swift
//  Mahesh System Task
//
//  Created by Apple on 29/10/18.
//  Copyright © 2018 Mahesh. All rights reserved.
//

import UIKit

class EditDataViewController: UIViewController {

    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var fullNameTextFiled: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    var userObject: UserDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.isEnabled = false
        
        // Setting data into editable fields
        loginTextField.text = userObject?.login
        fullNameTextFiled.text = userObject?.full_name
        descriptionTextView.text = userObject?.description ?? ""
        
        descriptionTextView.layer.cornerRadius = 5.0
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        descriptionTextView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    

    // Back Button Action
    @IBAction func backButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Update Data Button Action
    @IBAction func updateButtonTap(_ sender: Any) {
        userObject?.full_name = fullNameTextFiled.text
        userObject?.login = loginTextField.text
        userObject?.description = descriptionTextView.text
        
        UserDataInstance.instance.setEditedObject(object: userObject)
        
        dismiss(animated: true, completion: nil)
    }
    
}
// MARK: TextField Delegate
extension EditDataViewController: UITextFieldDelegate {
    // Will call if user any data edited
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateButton.isEnabled = true
        return true
    }
}

// MARK: TextView Delegate
extension EditDataViewController: UITextViewDelegate {
    // Will call if user any data edited
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        updateButton.isEnabled = true
        return true
    }
}
