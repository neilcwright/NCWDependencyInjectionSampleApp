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
    
    var presentLoggedInFlowExpectation: XCTestExpectation? = XCTestExpectation(description: "")
    var presentLoggedOutFlowExpectation: XCTestExpectation? = XCTestExpectation(description: "")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.presentLoggedInFlowExpectation = nil
        self.presentLoggedOutFlowExpectation = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let interactor = RootInteractor(dataManager: RootDataManager())
        interactor.presenter = self
        interactor.determineInitialFlow()
        
        XCTWaiter.wait(for: [self.presentLoggedOutFlowExpectation!], timeout: 10)
    }
}

// MARK: RootInteractorPresenterType
extension NCWDependencyInjectionSampleAppTests: RootInteractorPresenterType {
    func presentLoggedInFlow() {
        self.presentLoggedInFlowExpectation?.fulfill()
    }
    
    func presentLoggedOutFlow() {
        self.presentLoggedOutFlowExpectation?.fulfill()
    }
}
