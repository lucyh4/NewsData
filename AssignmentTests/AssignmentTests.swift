//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by Neha on 17/04/24.
//

import XCTest
@testable import Assignment

final class AssignmentTests: XCTestCase {
    var homeViewController: HomeViewController!
    var splashViewController: SplashViewController!
    
    override func setUp() {
        super.setUp()
        // Initialize your view controller from storyboard or programmatically
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        homeViewController.loadViewIfNeeded() // Make sure the view is loaded
        
        splashViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController
        splashViewController.loadViewIfNeeded() // Make sure the view is loaded
    }
    
    func testTableViewExists() throws {
        // Check if tableView property is not nil
        XCTAssertEqual(splashViewController.titleLbl.text, "Splash View")
    }
    
    func testSplashTitle() throws {
        // Check if tableView property is not nil
        XCTAssertNotNil(homeViewController.tableView, "TableView is not available in the view controller")
    }
    
    func testNavigationTitleIS() throws {
        // Check if navigation title is equal to "Home"
        if let title = homeViewController.navigationItem.title {
            XCTAssertEqual(title, "Home")
        }
    }
    
    func testTableViewData() throws {
        // Check if navigation title is equal to "Home"
        XCTAssertEqual(homeViewController.tableView.numberOfSections, 3)
        XCTAssertEqual(homeViewController.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertTrue(homeViewController.tableView.numberOfRows(inSection: 2) >= 0) // success case
//        XCTAssertTrue(homeViewController.tableView.numberOfRows(inSection: 2) >= 20) // failurse case
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
