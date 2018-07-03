//
//  ProviderAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/23/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject
import SwinjectPropertyLoader

final class ProviderAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // route provider type
        container.register(RouteProviderType.self) { resolver in
            return RouteProvider()
        }.inObjectScope(.container)
    }
    
    func loaded(resolver: Resolver) {
        print("provider assembly loaded")
    }
}
