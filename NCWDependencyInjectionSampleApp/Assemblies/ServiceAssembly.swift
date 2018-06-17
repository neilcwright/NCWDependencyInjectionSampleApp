//
//  ServiceAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/15/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject
import SwinjectPropertyLoader

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        // example service
        container.register(ExampleServiceType.self) {
            resolver in
            return ExampleService()
        }.initCompleted({
            resolver, service in
                
            print("example service initialized from container")
        }).inObjectScope(.graph)
    }
    
    func loaded(resolver: Resolver) {
        print("service assembly loaded")
    }
}
