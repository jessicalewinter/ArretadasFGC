//
//  RegisterAccountViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 31/08/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class RegisterAccountViewController: UIViewController {

    @IBOutlet weak var tableViewRegisterAccount: UITableView!
    let labels = ["Nome", "Email", "Ocupação", "Cidade", "Senha"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewRegisterAccount.register(UINib(nibName: "CardRegisterAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "CardRegisterAccountTableViewCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func register(){
        
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
            return cell


        } else{
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width/2, height: 50))
            
            let createAccountButton = PrimaryButton(frame: CGRect(x: tableView.bounds.width/4, y: 0, width: tableView.bounds.width/2, height: 50))
            createAccountButton.setTitle("Criar Conta", for: .normal)
//            createAccountButton.addTarget(self, action: #selector(register(sender:), for: .touchUpInside)
            cell.contentView.addSubview(createAccountButton)
            return cell
        }
    }
}

