//
//  HomeAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        
        // router
        container.register(HomeRouterType.self) { resolver in
            return HomeRouter()
        }.initCompleted({
            resolver, homeRouter in
            
            homeRouter.presenter = resolver.resolve(HomePresenterType.self)!
            print("home router: \(homeRouter)")
            
        }).inObjectScope(.graph)
        
        // presenter->router type
        container.register(HomePresenterRouterType.self) {
            resolver in
            return resolver.resolve(HomeRouterType.self)!
        }.initCompleted({
            resolver, homePresenter in
            
            print("home presenter-> router \(homePresenter)")
        })
        
        // presenter
        container.register(HomePresenterType.self) { resolver in
            return HomePresenter(interactor: resolver.resolve(HomeInteractorType.self)!)
        }.initCompleted({
            resolver, homePresenter in
            
            homePresenter.router = resolver.resolve(HomePresenterRouterType.self)!
            
        }).inObjectScope(.graph)
        
        // interactor
        container.register(HomeInteractorType.self) { resolver in
            return HomeInteractor()
        }.initCompleted({
            resolver, homeInteractor in
            
            homeInteractor.dataManager = resolver.resolve(HomeDataManagerType.self)!
            print("home interactor: \(homeInteractor)")
            
        }).inObjectScope(.graph)
        
        // data manager
        container.register(HomeDataManagerType.self) { resolver in
            return HomeDataManager()
        }.initCompleted({
            resolver, homeDataManager in
            
            // set up services in here
            
        }).inObjectScope(.graph)
        
        // view controller
        container.register(HomeViewControllerType.self) { resolver in
            return HomeViewController(presenter: resolver.resolve(HomePresenterType.self)!)
        }.initCompleted({
            resolver, homeViewController in
            
            print("home view controller")
        }).inObjectScope(.graph)
    }
    
    func loaded(resolver: Resolver) {
        print("home assembly loaded")
    }
}
