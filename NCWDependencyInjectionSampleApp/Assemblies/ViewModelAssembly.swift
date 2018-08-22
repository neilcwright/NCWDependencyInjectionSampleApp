//
//  ViewModelAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 7/14/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject
import SwinjectPropertyLoader

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        
        // MARK: PrimaryButtonModelType
        container.register(PrimaryButtonModelType.self) { resolver in
            return PrimaryButtonViewModel(
                cornerRadius: resolver.property("primary_button.corner_radius")!,
                horizontalInset: resolver.property("primary_button.horizontal_inset")!,
                verticalInset: resolver.property("primary_button.vertical_inset")!
            )
        }
        
        // MARK: InfoViewModelType
        container.register(InfoViewModelType.self) { resolver, headerText, descriptionText, imageName, primaryButtonText in
            return InfoViewModel(
                headerText: headerText,
                descriptionText: descriptionText,
                imageName: imageName,
                primaryButtonText: primaryButtonText
            )
        }
    }
    
    func loaded(resolver: Resolver) {
        print("model assembly loaded")
    }
}
