//
//  LoginViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 03/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var viewForm: UIView!
    @IBOutlet var loginOutlet: UIButton!
    @IBOutlet var singUpOutlet: UIButton!
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayput()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupLayput(){
        viewForm.addShadow()
        singUpOutlet.primaryButtton()
        loginOutlet.primaryButtton()
    }
    
    @IBAction func login(_ sender: UIButton) {
        // TODO: verificar campos
        let predicate = NSPredicate(format: "email == %@  AND password == %@", email.text!, password.text!)
        let result = DataManager.executeThe(query: predicate, forEntityName: "User") as! [User]
        if result.isEmpty {
            let alert = UIAlertController(title: "Senha ou email incorretos", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }else{
            user = result.first
            _ = self.navigationController?.popViewController(animated: true)
            //salvar id user
            UserDefaults.standard.set(true, forKey: "isLogged")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ProfileUserViewController {
            let dest = segue.destination as! ProfileUserViewController
            dest.user = self.user
        }
    }
    
    
}
