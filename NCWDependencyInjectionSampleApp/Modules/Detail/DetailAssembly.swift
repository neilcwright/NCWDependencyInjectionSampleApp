//
//  DetailAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject

class DetailAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // data manager
        container.register(DetailDataManagerType.self) { resolver in
            return DetailDataManager(exampleService: resolver.resolve(ExampleServiceType.self)!)
        }.inObjectScope(.graph)
        
        // interactor
        container.register(DetailInteractorType.self) {
            resolver in
            return DetailInteractor()
        }.initCompleted({ resolver, interactor in
            interactor.dataManager = resolver.resolve(DetailDataManagerType.self)!
        }).inObjectScope(.graph)
        
        // presenter
        container.register(DetailPresenterType.self) { resolver in
            return DetailPresenter(interactor: resolver.resolve(DetailInteractorType.self)!)
        }.initCompleted({ resolver, presenter in
            presenter.router = resolver.resolve(DetailPresenterRouterType.self)!
        }).inObjectScope(.graph)
        
        // router
        container.register(DetailPresenterRouterType.self) { resolver in
            return resolver.resolve(DetailRouterType.self)!
        }.inObjectScope(.graph)
        
        // view controller
        container.register(DetailViewControllerType.self) { resolver in
            return DetailViewController(presenter: resolver.resolve(DetailPresenterType.self)!)
        }.inObjectScope(.graph)
    }
    
    func loaded(resolver: Resolver) {
        print("detail assembly loaded")
    }
}
