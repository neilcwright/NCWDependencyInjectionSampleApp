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
        
        // PrimaryButtonViewModel
        container.register(PrimaryButtonModelType.self) { resolver in
            return PrimaryButtonViewModel(
                cornerRadius: resolver.property("primary_button.corner_radius")!,
                horizontalInset: resolver.property("primary_button.horizontal_inset")!,
                verticalInset: resolver.property("primary_button.vertical_inset")!
            )
        }
    }
    
    func loaded(resolver: Resolver) {
        print("model assembly loaded")
    }
}
