//
//  HomeAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject
import SwinjectPropertyLoader

class HomeAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // router
        container.register(HomeRouterType.self) { resolver in
            return HomeRouter()
        }.initCompleted({
            resolver, homeRouter in
            
            homeRouter.routeProvider = resolver.resolve(RouteProviderType.self)!
        }).inObjectScope(.weak)

        // presenter
        container.register(HomePresenterType.self) { resolver in
            return HomePresenter(interactor: resolver.resolve(HomeInteractorType.self)!)
        }.initCompleted({
            resolver, homePresenter in
            
            homePresenter.router = resolver.resolve(HomeRouterType.self)!
        }).inObjectScope(.graph)
        
        // interactor
        container.register(HomeInteractorType.self) { resolver in
            return HomeInteractor()
        }.initCompleted({
            resolver, homeInteractor in
            
            homeInteractor.dataManager = resolver.resolve(HomeDataManagerType.self)!
        }).inObjectScope(.graph)
        
        // data manager
        container.register(HomeDataManagerType.self) { resolver in
            return HomeDataManager()
        }.inObjectScope(.graph)
        
        // view controller
        container.register(HomeViewControllerType.self) { resolver in
            return HomeViewController(presenter: resolver.resolve(HomePresenterType.self)!)
        }.initCompleted({
            resolver, viewController in
            
            viewController.imageName = resolver.property("home_view_image_name")
        }).inObjectScope(.graph)
    }
    
    func loaded(resolver: Resolver) {
        print("home assembly loaded")
    }
}
