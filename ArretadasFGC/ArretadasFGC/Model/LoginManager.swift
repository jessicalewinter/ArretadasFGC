//
//  LoginManager.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 05/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import CoreData

class LoginManager: NSObject {

    static func isValid(email: String, password: String)-> (success: Bool, object: NSManagedObject?){
        let predicate = NSPredicate(format: "email == %@  AND password == %@", email, password)
        let result = DataManager.executeThe(query: predicate, forEntityName: "User") as! [User]
        
        if result.isEmpty {
            return (false, nil)
        }
        return (true, result.first)
        
    }
}
