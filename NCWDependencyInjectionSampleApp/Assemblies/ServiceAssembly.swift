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
        
        // MARK: - AccountServiceType
        container.register(AccountServiceType.self) { resolver in
            return AccountService(baseUrl: resolver.property("base_url")!)
        }
    }
    
    func loaded(resolver: Resolver) {
        print("service assembly loaded")
    }
}
