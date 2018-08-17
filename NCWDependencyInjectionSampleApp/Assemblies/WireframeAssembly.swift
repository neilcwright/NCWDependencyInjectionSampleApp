//
//  AppRouterAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/23/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject
import SwinjectPropertyLoader

final class WireframeAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Wirefrane type. This gets injected into all routes, as a way to access other
        // routes from the container. Use `.container` object scope
        // since we only want one instance of route provider to be injected into our routers.
        container.register(WireframeType.self) { resolver in
            return Wireframe()
        }.inObjectScope(.container)
    }
    
    func loaded(resolver: Resolver) {
        print("wireframe assembly loaded")
    }
}
