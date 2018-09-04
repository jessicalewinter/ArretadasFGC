//
//  RegisterAccountViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 04/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import XCTest
@testable import ArretadasFGC

class RegisterAccountViewController: XCTestCase {
	
	var vcRegister: RegisterAccountViewController!
	var user: User?
	
    override func setUp() {
        super.setUp()
		
    }
	
	func test_registerAccount_sucess(){
		user?.city = "Cidade"
		user?.email = "Cidade"
		user?.name = "Cidade"
		user?.password = "Cidade"
		//user?.photo = 
		
	}
	
	
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	
    
}
