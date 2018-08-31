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
    @IBOutlet weak var tableViewRegisterAccount: UITableView!
    
    //constantes
    let labels = ["Nome", "Email", "Ocupação", "Cidade", "Senha"]
    let dbManager = DataManager()
    
    //vaiaveis
    var pickedImageName = ""
    var user: User!
    var imagePicker = UIImagePickerController()
    var tapGestureRecognizer: UITapGestureRecognizer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.tableViewRegisterAccount.register(UINib(nibName: "CardRegisterAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "CardRegisterAccountTableViewCell")
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        initialConfg()
    }

    func initialConfg(){
        user = User(context: dbManager.getContext())
        viewHeader.nameLabel.isHidden = true
        viewHeader.profileImageView.isUserInteractionEnabled = true
        viewHeader.profileImageView.addGestureRecognizer(tapGestureRecognizer!)
        
    }
    
    @objc func register(sender: UIButton){
        dbManager.saveContext()
        let e = dbManager.getEntity(entity: "User")
        let re = dbManager.getAll(entity: e)
        if re.success{
            print(re.objects.count)
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
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

extension RegisterAccountViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < tableView.numberOfRows(inSection: 0) - 1{
            let cell = self.tableViewRegisterAccount.dequeueReusableCell(withIdentifier: "CardRegisterAccountTableViewCell", for: indexPath) as! CardRegisterAccountTableViewCell
            
            cell.labelRegisterAccount.text = labels[indexPath.row]
            cell.labelRegisterAccount.sizeToFit()
            
            if indexPath.row == 0 || indexPath.row == 1{
                cell.labelRequired.text = "*"
                cell.labelRequired.textColor = UIColor.red
            }else{
                cell.labelRequired.text = ""
            }
            cell.textFieldRegisterAccount.delegate = self
            return cell


        } else{
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width/2, height: 50))
            
            let createAccountButton = PrimaryButton(frame: CGRect(x: tableView.bounds.width/4, y: 0, width: tableView.bounds.width/2, height: 50))
            createAccountButton.setTitle("Criar Conta", for: .normal)
            createAccountButton.addTarget(self, action: #selector(register(sender:)), for: .touchUpInside)
            cell.contentView.addSubview(createAccountButton)
            return cell
        }
    }
}

extension RegisterAccountViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        
        let ActualText = (textField.text ?? "") + string
        switch textField.tag
        {
        case 0:
            user.name = ActualText;
        case 1:
            user.email = ActualText;
        case 2:
            user.profession = ActualText;
        case 3:
            user.city = ActualText;
        case 4:
            user.password = ActualText;
        default:
            print("It is nothing");
        }
        return true;
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
