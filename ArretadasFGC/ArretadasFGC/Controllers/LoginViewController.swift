//
//  LoginViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 03/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //Outlets UIBUtton
    @IBOutlet var loginOutlet: UIButton!
    @IBOutlet var singUpOutlet: UIButton!
    
    //Outlets textFields
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    
    //Outlets views
    @IBOutlet var viewForm: UIView!

    //instaces
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayput()

    }
    
    func setupLayput(){
        viewForm.addShadow()
        singUpOutlet.primaryButtton()
        loginOutlet.primaryButtton()
    }
    
    @IBAction func login(_ sender: UIButton) {
        if !Register.checkTextFieldIsEmpty(textFields: [password, email]) {
            let result = LoginManager.isValid(email: email.text!, password: password.text!)
            if result.success{
                user = result.object as? User
                _ = self.navigationController?.popViewController(animated: true)
            }else{
                let alert = UIAlertController(title: "Senha ou email incorretos", message: nil, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                    alert.dismiss(animated: true, completion: nil)
                }
            }
            
        }else{
            let alert = UIAlertController(title: "Preencha todos os campos", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ProfileUserViewController {
            let dest = segue.destination as! ProfileUserViewController
            dest.user = self.user
        }
    }
    
}

