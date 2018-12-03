//
//  Mindvalley_TestTests.swift
//  Mindvalley TestTests
//
//  Created by Mobile World on 7/27/17.
//  Copyright © 2017 Coca Denisa. All rights reserved.
//

import XCTest
@testable import Mindvalley_Test

class Mindvalley_TestTests: XCTestCase {
    
    var viewModel: ImageListViewModel?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let viewController = ImageListViewController()
        viewModel = viewController.viewModel
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        viewModel?.fetchDataFromAPI()
        let dataPulled = expectation(description: "data populated successfully")
        while (viewModel?.data.count)!  > 0{
            dataPulled.fulfill()
            break
        }
    
        // Wait for the async request to complete
        waitForExpectations(timeout: 10, handler: {[unowned self](error) in
            for imageDataModel in self.viewModel?.data ?? []{
                XCTAssertNotNil(imageDataModel.id, "The id has valid value")
                XCTAssertGreaterThan(imageDataModel.width!, 0, "The width has valid value")
                XCTAssertGreaterThan(imageDataModel.height!, 0, "The height has valid value")
                XCTAssertNotNil(imageDataModel.createdAt, "The created date has valid value")
                XCTAssertNotNil(imageDataModel.color, "The color has valid value")

                
                XCTAssertGreaterThan(imageDataModel.likes!, 0, "The likes has valid value")
                if imageDataModel.likedByUser == true{
                    XCTAssert(true, "The image has been liked by the user")
                }
                else{
                    XCTAssert(true, "The image has not been liked by the user")
                }
                XCTAssertNotNil(imageDataModel.user, "The user details is valid")
                XCTAssertNotNil(imageDataModel.user?.id, "The user id is valid")
                if imageDataModel.user?.name != nil{
                    XCTAssert(true, "The user has valid name")
                }
                else{
                    XCTAssert(true, "The user has no name")
                }
                if imageDataModel.user?.name != nil{
                    XCTAssert(true, "The username is valid")
                }
                else{
                    XCTAssert(true, "The username has no value")
                }
                
                XCTAssertNotNil(imageDataModel.user?.profileImage, "The profile image is valid")
                
                XCTAssertNotNil(imageDataModel.urls!, "The image urls are valid")
                

                for category in imageDataModel.categories ?? []  {
                    if category.id != nil{
                        XCTAssert(true, "The category id is valid")
                    }
                    else{
                        XCTAssert(true, "The category id has no value")
                    }
                    XCTAssertNotNil(category.title, "The category title is valid")
                    if category.photoCount != nil{
                        XCTAssert(true, "The category has a number of photos")
                    }
                    else{
                        XCTAssert(true, "The category has no photos")
                    }
                    XCTAssertNotNil(category.links, "The category links is valid")
                }
                
                XCTAssertNotNil(imageDataModel.links!, "The links are valid")

            }
        })
        
        
        
    }
    
}
