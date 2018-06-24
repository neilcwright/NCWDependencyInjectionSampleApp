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
        }
        
        // interactor
        container.register(DetailInteractorType.self) {
            resolver in
            return DetailInteractor()
        }.initCompleted({ resolver, interactor in
            interactor.dataManager = resolver.resolve(DetailDataManagerType.self)!
        })
        
        // presenter
        container.register(DetailPresenterType.self) { resolver in
            return DetailPresenter(interactor: resolver.resolve(DetailInteractorType.self)!)
        }.initCompleted({ resolver, presenter in
            presenter.router = resolver.resolve(DetailRouterType.self)!
        })
        
        // router
        container.register(DetailRouterType.self) { resolver in
            return DetailRouter()
            }.initCompleted({ resolver, router in
                router.routeProvider = resolver.resolve(RouteProviderType.self)!
            }).inObjectScope(.weak)
        
        // view controller
        container.register(DetailViewControllerType.self) { resolver in
            return DetailViewController(presenter: resolver.resolve(DetailPresenterType.self)!)
        }
    }
    
    func loaded(resolver: Resolver) {
        print("detail assembly loaded")
    }
}
