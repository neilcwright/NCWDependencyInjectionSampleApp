//
//  DetailDataManager.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

protocol DetailDataManagerType: class {
    var exampleService: ExampleServiceType { get }
}

final class DetailDataManager: DetailDataManagerType {
    var exampleService: ExampleServiceType
    
    init(exampleService: ExampleServiceType) {
        self.exampleService = exampleService
    }
}
