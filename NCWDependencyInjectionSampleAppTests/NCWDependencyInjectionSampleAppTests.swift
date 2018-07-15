//
//  NCWDependencyInjectionSampleAppTests.swift
//  NCWDependencyInjectionSampleAppTests
//
//  Created by Neil Wright on 6/15/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//
import Swinject
import XCTest

@testable import NCWDependencyInjectionSampleApp

final class MockRootAssembly: RootAssembly {
    
}

class NCWDependencyInjectionSampleAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //let rootInteractor = (UIApplication.shared.delegate as? AppDelegate)?.routeProvider
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
