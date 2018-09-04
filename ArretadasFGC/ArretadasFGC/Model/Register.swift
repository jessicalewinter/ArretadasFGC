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
}


