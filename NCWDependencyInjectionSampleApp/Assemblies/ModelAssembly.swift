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
        // register any model types to container here
    }
    
    func loaded(resolver: Resolver) {
        print("model assembly loaded")
    }
}
