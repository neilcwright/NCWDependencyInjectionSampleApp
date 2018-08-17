//
//  RootDataManager.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

protocol RootDataManagerType: class {
    func isUserLoggedIn() -> Bool
}

final class RootDataManager: RootDataManagerType {
    
    deinit {
        print("root data manager deinit")
    }
    
    func isUserLoggedIn() -> Bool {
        // TODO for mocking store a key/value pair in user defaults to simulate
        // coming back after initial log in
        return false
    }
}
