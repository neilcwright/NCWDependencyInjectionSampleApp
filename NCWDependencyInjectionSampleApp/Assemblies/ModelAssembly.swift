//
//  ModelAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject
import SwinjectPropertyLoader

class ModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Foo.self) {
            _, thing in
            return FooThing(thing: thing)
            }.initCompleted({
                resolver, foo in
                
                foo.setThing(resolver.property("foo_property")!)
                print("foo thing changed: \(foo.description)")
            })
        
        container.register(Bar.self) {
            r, thing in
            return BarThing(thing: thing)
        }
    }
    
    func loaded(resolver: Resolver) {
        print("model assembly loaded")
    }
}
