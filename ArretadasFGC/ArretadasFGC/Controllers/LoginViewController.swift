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
    @IBOutlet var password: UILabel!
    @IBOutlet var email: UITextField!
    
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
        let entity = DataManager.getEntity(entity: "User")
        let result = DataManager.getAll(entity: entity)
        var users = Array<User>()
        if result.success {
            users = result.objects as! Array<User>
        }else{
            NSLog("Error on fetch Users")
        }
        
        let user = users.filter { (user) -> Bool in
            if user.email == email.text && user.password == password.text {
                return true
            }
            return false
            
        }
        if user.isEmpty {
            let alert = UIAlertController(title: "Senha ou email errados", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }else{
            print("wse")
        }
    }
    
    
}
