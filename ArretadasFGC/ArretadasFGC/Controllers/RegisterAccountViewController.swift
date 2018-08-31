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
        
        self.tableViewRegisterAccount.register(UINib(nibName: "CardRegisterAccountForm", bundle: nil), forCellReuseIdentifier: "CardRegisterAccountForm")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RegisterAccountViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewRegisterAccount.dequeueReusableCell(withIdentifier: "CardRegisterAccountForm", for: indexPath) as! CardRegisterAccountForm
        
        return cell
    }
    
    
}
