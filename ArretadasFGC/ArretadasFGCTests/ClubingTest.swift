//
//  ClubingTest.swift
//  ArretadasFGCTests
//
//  Created by Ada 2018 on 05/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import XCTest
@testable import ArretadasFGC

class ClubingTest: XCTestCase {
	let profile =  ProfileClub()
	var user1: User!
	var user2: User!
	
	
    override func setUp() {
		super.setUp()
		user1 = User(context: DataManager.getContext())
		user2 = User(context: DataManager.getContext())
		
		user1.name = "Talya"
		user2.name = "Gessyka"
	
	}
	
	override func tearDown() {
		super.tearDown()
		user1 = nil
		user2 = nil
	}
	
	
	func test_isAMember_success(){
		
		
		let results = profile.isAMember(user: user1, members: [user1, user2])
		XCTAssertTrue(results)
	}
	
	func test_isAMember_fail(){
		
		let results = profile.isAMember(user: user1, members: [user2])
		XCTAssertFalse(results)
	}
    
	
	
}
