//
//  RootAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject

class RootAssembly: Assembly {
    func assemble(container: Container) {
        
        // router type
        container.register(RootRouterType.self) {
            resolver in
            
            return RootRouter()
        }.initCompleted({
            resolver, router in
            
            router.routeProvider = resolver.resolve(RouteProviderType.self)!
            print("root router initialized \(router)")
        })
        
        // router presenter type
        container.register(RootRouterPresenterType.self) {
            resolver in
            
            return resolver.resolve(RootRouterType.self)!
        }.initCompleted({
            resolver, router in
                
            print("root router presenter type initialized")
        })
        
        // data manager
        container.register(RootDataManagerType.self) {
            resolver in
            
            return RootDataManager()
        }.initCompleted({
            resolver, dataManager in
            
            print("root data manager initialized")
        })
        
        // interactor
        container.register(RootInteractorType.self) {
            resolver in
            
            return RootInteractor()
        }.initCompleted({
            resolver, interactor in
            
            interactor.dataManager = resolver.resolve(RootDataManagerType.self)!
            interactor.presenter = resolver.resolve(RootInteractorPresenterType.self)!
            print("root interactor initialized")
        })
        
        // interactor->presenter type
        container.register(RootInteractorPresenterType.self) {
            resolver in
            return RootPresenter()
        }.initCompleted({
            resolver, presenter in
            
            print("root interactor/presenter type initialized")
        })
        
        // presenter
        container.register(RootPresenterType.self) {
            resolver in
            
            return RootPresenter()
        }.initCompleted({
            resolver, presenter in
            
            presenter.interactor = resolver.resolve(RootInteractorType.self)!
            presenter.router = resolver.resolve(RootRouterPresenterType.self)!
            
            print("root router presenter type initialized")
        })
        
        // view controller
        container.register(RootViewControllerType.self) {
            resolver in
            return RootViewController(presenter: resolver.resolve(RootPresenterType.self)!)
        }.initCompleted({
            resolver, viewController in
            
            print("root view controller initialized \(viewController)")
        })
    }
    
    func loaded(resolver: Resolver) {

    }
}
