//
//  AddClubViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 03/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import SearchTextField

class AddClubViewController: UIViewController {

    //Outlets textField
    @IBOutlet var privacy: UITextField!
    @IBOutlet var city: SearchTextField!
    @IBOutlet var local: SearchTextField!
    @IBOutlet var clubDescription: UITextView!
    @IBOutlet var name: UITextField!
   
    //Outlets imageView e view
    @IBOutlet var viewForm: UIView!
    @IBOutlet var image: UIImageView!
    
    //Outlets others
    @IBOutlet var scView: UIScrollView!
    
    
    let privacyPicker = UIPickerView()
    let privacyTypes = ["Aberto", "Fechado", "Privado"]
    
    var user: User?
    var nameImagePicker = ""
    var activeField: UITextField!
    var imagePicker = UIImagePickerController()
    var accessoryToolbar: UIToolbar {
        get {
            let toolbarFrame = CGRect(x: 0, y: 0,
                                      width: view.frame.width, height: 44)
            let accessoryToolbar = UIToolbar(frame: toolbarFrame)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                             target: self,
                                             action: #selector(onDoneButtonTapped(sender:)))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil)
            accessoryToolbar.items = [flexibleSpace, doneButton]
            accessoryToolbar.barTintColor = UIColor.white
            return accessoryToolbar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubDescription.layer.borderWidth = 0.3
        clubDescription.layer.borderColor = UIColor.lightGray.cgColor
        clubDescription.layer.cornerRadius = 5
        clubDescription.clipsToBounds = true
        viewForm.addShadow()
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        privacyPicker.delegate = self
        imagePicker.delegate = self
        privacy.inputView = privacyPicker
        privacy.inputAccessoryView = accessoryToolbar
        privacy.text = privacyTypes[0]
        privacyPicker.selectRow(0, inComponent: 0, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
        //suggestions search text field
        SearchTextFieldModel.configureSimple(SearchTextField: city)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func done(_ sender: UIButton) {
        if !Register.checkTextFieldIsEmpty(textFields: [privacy, city, local, name]){
            let newClub = Club(context: DataManager.getContext())
            newClub.local = local.text
            newClub.city = city.text
            newClub.name = name.text
            newClub.descriptionClub = clubDescription.text
            newClub.photo = StoreMidia.saving(image: image.image!, withName: nameImagePicker)
            user?.addToClubs(newClub)
            DataManager.saveContext()
            dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Preencha todos os campos", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
       
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, targetFrame.height, 0.0)
        scView.contentInset = contentInsets
        scView.scrollIndicatorInsets = contentInsets
        
        var aRect = self.view.frame
        aRect.size.height -= targetFrame.height
        if (activeField != nil && !aRect.contains(activeField.frame.origin)) {
            scView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    @objc func keyboardWillHide(notif: Notification){
        let contentInsets = UIEdgeInsetsFromString("")
        scView.contentInset = contentInsets
        scView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func onDoneButtonTapped(sender: UIBarButtonItem) {
        if privacy.isFirstResponder {
            privacy.resignFirstResponder()
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let _ = tapGestureRecognizer.view as! UIImageView
        
        let actionSheet: UIAlertController = UIAlertController(title: "Capture an image", message: "Choose an option", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default)
        { _ in
            guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) else {
                let alert: UIAlertController = UIAlertController(title: "Oops...", message: "Camera is not available", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.imagePicker.sourceType = .camera
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let galeriaAction = UIAlertAction(title: "Library", style: .default)
        { _ in
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(galeriaAction)
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
}

extension AddClubViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
}

extension AddClubViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return privacyTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return privacyTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.privacy.text = privacyTypes[row]
    }
}
extension AddClubViewController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.image.image = pickedImage
            self.nameImagePicker = "Arretadas\(pickedImage.hashValue)"
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

