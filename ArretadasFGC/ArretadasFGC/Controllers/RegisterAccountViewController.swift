//
//  RegisterAccountViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 31/08/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class RegisterAccountViewController: UIViewController {

    //outlets
    @IBOutlet var viewHeader: BackgroundUser!
    @IBOutlet var name: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var profession: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var viewCard: UIView!
    @IBOutlet var scView: UIScrollView!

    
    //constantes
    let labels = ["Nome", "Email", "Ocupação", "Cidade", "Senha"]
    let dbManager = DataManager()
    
    //vaiaveis
    var pickedImageName = ""
    var newUser: User!
    var imagePicker = UIImagePickerController()
    var tapGestureRecognizer: UITapGestureRecognizer? = nil
    var activeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        initialConfg()

    }

    func initialConfg(){
        viewCard.layer.cornerRadius = 5
        viewCard.layer.shadowColor = #colorLiteral(red: 0.4390000105, green: 0.4390000105, blue: 0.4390000105, alpha: 1)
        viewCard.layer.shadowRadius = 1
        viewCard.layer.shadowOpacity = 0.3
        viewCard.layer.shadowOffset = CGSize.init(width: 4.0, height: 4.0)
        viewCard.clipsToBounds = true
        viewCard.layer.masksToBounds = false
        registerButton.sizeToFit()
        registerButton.primaryButtton()
        registerButton.titleLabel?.sizeToFit()
        newUser = User(context: dbManager.getContext())
        viewHeader.nameLabel.isHidden = true
        viewHeader.profileImageView.isUserInteractionEnabled = true
        viewHeader.profileImageView.addGestureRecognizer(tapGestureRecognizer!)
        
    }
    
    // Getting the information in textFiels and saving in Core Data
    @IBAction func registerAccount(_ sender: UIButton) {
        if (self.city.text == "" || self.name.text == "" || self.email.text == "" || self.password.text == "" || self.profession.text == ""){
            let alert = UIAlertController(title: "Complete all the fields", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }else{
            newUser.city = self.city.text
            newUser.password = self.password.text
            newUser.profession = self.profession.text
            newUser.name = self.name.text
            newUser.email = self.email.text
            newUser.photo = self.savingImage()
            dbManager.saveContext()
        }
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
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        _ = tapGestureRecognizer.view as! UIImageView
        
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
    
    //get the image choosen, save in the File Manager and return the path
    func savingImage() -> String {
        
        let fileManager = FileManager.default
        let directory = "Images"
        var filePath = ""
        if let documentDirectory = try fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let documentoDiretorio = documentDirectory.appendingPathComponent(directory)
            
            let saida = FileManager.default.fileExists(atPath: documentoDiretorio.path)
            if !saida {
                do {
                    try FileManager.default.createDirectory(atPath: documentoDiretorio.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print(error)
                }
            }
        }
        if let data = UIImageJPEGRepresentation(viewHeader.profileImageView.image!, 1){
            if let path = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL{
                do {
                    filePath = "/\(directory)/\(self.pickedImageName).jpeg"
                    try data.write(to: path.appendingPathComponent(filePath)!)
                    print("Succes in Save Photo!")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        return filePath
    }
    
    
}


extension RegisterAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.viewHeader.profileImageView.image = pickedImage
            self.pickedImageName = "Arretada\(pickedImage.hashValue)"
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIButton{
    func primaryButtton(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primary.cgColor
        self.titleEdgeInsets = UIEdgeInsets(top: 15.0, left: 5.0, bottom: 15.0, right: 5.0)
        
        self.setTitleColor(UIColor.primary, for: .normal)
    }
}
