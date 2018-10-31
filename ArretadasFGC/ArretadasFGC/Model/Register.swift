//
//  Register.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 04/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class Register {

	static func checkTextFieldIsEmpty(textFields: [UITextField]) -> Bool{
		for textField in textFields{
			if textField.text == "" {
				return true
			}
		}
		return false
	}
	static func validateRegister(emial: String) -> Bool{
        let predicate = NSPredicate(format: "email == %@", email)
        guard let result = DataManager.executeThe(query: predicate, forEntityName: "User") as? [User] else {return false}
        
        if result.isEmpty {
            return true
        }else{
            return false
        }
        
}
}


