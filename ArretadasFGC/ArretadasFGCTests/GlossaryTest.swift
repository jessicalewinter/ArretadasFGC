//
//  GlossaryTest.swift
//  ArretadasFGCTests
//
//  Created by Ada 2018 on 05/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import XCTest
@testable import ArretadasFGC

class GlossaryTest: XCTestCase {
	var glossary: Glossary?
	
    override func setUp() {
        super.setUp()
		glossary = Glossary()
    }
    
    override func tearDown() {
       glossary = nil
        super.tearDown()
    }
	
	func test_readPlist_success(){
		let result = glossary?.readPlist(named: "GlossaryData", bundle: Bundle.main)
		XCTAssertNotNil(result)
	}
	
	func test_readPlist_fail(){
		let result = glossary?.readPlist(named: "Glossary", bundle: Bundle.main)
		XCTAssertNil(result)
	}
    
}
