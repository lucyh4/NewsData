//
//  HomeServiceTests.swift
//  AssignmentTests
//
//  Created by Neha on 20/04/24.
//

import XCTest
@testable import Assignment

class HomeServiceTests: XCTestCase {
    
    // Mock ServiceManager to simulate network responses
    class MockServiceManager: ServiceManager {
        var jsonData: [String: Any]?
        var error: DError?
        
        func get(with url: String, parameters: [String: Any]?, headers: [String: String]?, success: @escaping ([String: Any]?) -> Void, failure: @escaping (DError) -> Void) {
            if let jsonData = jsonData {
                success(jsonData)
            } else if let error = error {
                failure(error)
            } else {
                failure(DError(code: .unknown))
            }
        }
    }
    
    var homeService: HomeServiceImp!
    var mockServiceManager: MockServiceManager!
    
    override func setUp() {
        super.setUp()
        mockServiceManager = MockServiceManager()
        homeService = HomeServiceImp(serviceManager: mockServiceManager)
    }
    
    override func tearDown() {
        homeService = nil
        mockServiceManager = nil
        super.tearDown()
    }
    
    func testGetBBCNewsDetailsSuccess() {
        let expectation = XCTestExpectation(description: "Get BBC News Details Success")
        
        // mock response data
        let mockJsonData: [String: Any] = ["status": "ok", "totalResults": 10]
        mockServiceManager.jsonData = mockJsonData
        
        // request model
        let requestModel = NewsRequestBody(sources: "bbc-news", apiKey: Constants.API_KEY)
        
        homeService.getBBCNewsDetails(requestModel: requestModel, success: { newsResponse in
            // Assert that success callback is called with expected data
            XCTAssertEqual(newsResponse.status, "ok")
            XCTAssertEqual(newsResponse.totalResults, 10)
            expectation.fulfill()
        }, failure: { _ in
            XCTFail("Expected success, got failure")
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetBBCNewsDetailsFailure() {
        let expectation = XCTestExpectation(description: "Get BBC News Details Failure")
        
        // Set up mock error
        let mockError = DError(code: .unknown)
        mockServiceManager.error = mockError
        
        // Define a dummy request model
        let requestModel = NewsRequestBody(sources: "bbc-news", apiKey: Constants.API_KEY)
        
        homeService.getBBCNewsDetails(requestModel: requestModel, success: { _ in
            XCTFail("Expected failure, got success")
        }, failure: { error in
            // Assert that failure callback is called with expected error
            XCTAssertEqual(error.code, .unknown)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
}
