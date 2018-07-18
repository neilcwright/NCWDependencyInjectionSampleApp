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
            
            homeRouter.appRouter = resolver.resolve(AppRouterType.self)!
        }).inObjectScope(.weak)

        // presenter
        container.register(HomePresenterType.self) { resolver in
            return HomePresenter(interactor: resolver.resolve(HomeInteractorType.self)!)
        }.initCompleted({
            resolver, homePresenter in
            
            let router = resolver.resolve(HomeRouterType.self)!
            homePresenter.router = router as HomePresenterToRouterType
            
        }).inObjectScope(.graph)
        
        // presenter->router
        container.register(HomePresenterToRouterType.self) { resolver in
            let homeRouter = resolver.resolve(HomeRouterType.self)!
            return homeRouter as HomePresenterToRouterType
        }
        
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
            return HomeViewController(
                presenter: resolver.resolve(HomePresenterType.self)!,
                viewModel: resolver.resolve(HomeViewModelType.self)!
            )
        }.inObjectScope(.graph)
        
        // Models
        
        // view model
        container.register(HomeViewModelType.self) { resolver in
            let imageName: String = resolver.property("home_view_image_name")!
            return HomeViewModel(
                infoViewModel: resolver.resolve(
                    InfoViewModelType.self,
                    arguments: HomeLocalization.titleText,
                    HomeLocalization.descriptionText,
                    imageName,
                    HomeLocalization.primaryButtonText
                )!
            )
        }
    }
    
    func loaded(resolver: Resolver) {
        print("home assembly loaded")
    }
}
