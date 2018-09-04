//
//  Register.swift
//  ArretadasFGCTests
//
//  Created by Ada 2018 on 04/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import XCTest
@testable import ArretadasFGC

class RegisterTests: XCTestCase {
	var user: User?

    override func setUp() {
        super.setUp()
    }
	
	func test_checkTextFieldIsEmpty_success(){
		
		let result = Register.checkTextFieldIsEmpty(textFields: [UITextField()])
		
		XCTAssertTrue(result)

	}
	
	func test_checkTextFieldIsEmpty_error() {
		let field = UITextField()
	 	field.text = "algo"
		let result = Register.checkTextFieldIsEmpty(textFields: [field])
		
		XCTAssertFalse(result)
	}
	
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
