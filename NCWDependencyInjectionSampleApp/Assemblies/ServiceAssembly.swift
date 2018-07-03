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
        container.register(LoginServiceType.self) { resolver in
            return LoginService(baseUrl: resolver.property("base_url")!)
        }
    }
    
    func loaded(resolver: Resolver) {
        print("service assembly loaded")
    }
}
