//
//  ProfileUserTeste.swift
//  ArretadasFGCTests
//
//  Created by Ada 2018 on 05/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import XCTest
@testable import ArretadasFGC

class ProfileUserTest: XCTestCase {
    
    var viewController: ProfileUserViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "ProfileUser", bundle: Bundle.main)
        viewController = storyboard.instantiateInitialViewController() as! ProfileUserViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
       
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_CanInstantiateViewController() {
       XCTAssertNotNil(viewController.view)
    }
    
    func testTableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(viewController.tableView)
    }
    func test_HasCellsForTableView() {
        XCTAssertNotNil(viewController.tableView.visibleCells)
    }
    func test_ShouldSetTableViewDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource)
    }
    func test_ConformsToTableViewDataSource() {
        
//        XCTAssert(viewController.conformsToProtocol(UITableViewDataSource))
//        XCTAssertTrue(viewController.respondsToSelector(#selector(viewController.tableView(_:numberOfItemsInSection:))))
//        XCTAssertTrue(viewController.respondsToSelector(#selector(viewController.tableView(_:cellForItemAtIndexPath:))))
    }
    

    
}
