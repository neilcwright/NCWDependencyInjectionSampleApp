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
        
        // route provider type. This gets injected into all routes, as a way to access other
        // routes from the container that backs the route provider. Use `.container` object scope
        // since we only want one instance of route provider to be injected into our routers.
        container.register(RouteProviderType.self) { resolver in
            return RouteProvider()
        }.inObjectScope(.container)
    }
    
    func loaded(resolver: Resolver) {
        print("provider assembly loaded")
    }
}
