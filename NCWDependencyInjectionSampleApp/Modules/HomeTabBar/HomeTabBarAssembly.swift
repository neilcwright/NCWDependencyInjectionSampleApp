//
//  HomeTabBarAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import Swinject

class HomeTabBarAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // router type
        container.register(HomeTabBarRouterType.self) { resolver in
            return HomeTabBarRouter()
        }.initCompleted({ resolver, router in
            router.appRouter = resolver.resolve(AppRouterType.self)!
        }).inObjectScope(.weak)
        
        // presenter/router type
        container.register(HomeTabBarPresenterToRouterType.self) { resolver in
            return resolver.resolve(HomeTabBarRouterType.self)!
        }.initCompleted({ resolver, router in
            (router as? HomeTabBarRouterType)?.appRouter = resolver.resolve(AppRouterType.self)!
        })
        
        // data manager
        container.register(HomeTabBarDataManagerType.self) { resolver in
            return HomeTabBarDataManager()
        }
        
        // interactor
        container.register(HomeTabBarInteractorType.self) { resolver in
            return HomeTabBarInteractor(dataManager: resolver.resolve(HomeTabBarDataManagerType.self)!)
        }.initCompleted({ resolver, interactor in
            interactor.presenter = resolver.resolve(HomeTabBarInteractorPresenterType.self)!
        })
        
        // presenter
        container.register(HomeTabBarPresenterType.self) { resolver in
            return HomeTabBarPresenter(interactor: resolver.resolve(HomeTabBarInteractorType.self)!)
        }.initCompleted({ resolver, presenter in
            presenter.router = resolver.resolve(HomeTabBarRouterType.self)!
            presenter.view = resolver.resolve(HomeTabBarPresenterToViewType.self)!
        })
        
        // presenter->view type
        container.register(HomeTabBarPresenterToViewType.self) { resolver in
            let viewController = resolver.resolve(HomeTabBarViewControllerType.self)!
            return viewController as! HomeTabBarPresenterToViewType
        }
        
        // interactor->presenter type
        container.register(HomeTabBarInteractorPresenterType.self) { resolver in
            let presenter = resolver.resolve(HomeTabBarPresenterType.self)!
            return presenter as! HomeTabBarInteractorPresenterType
        }
        
        // view controller
        container.register(HomeTabBarViewControllerType.self) { resolver in
            return HomeTabBarViewController(presenter: resolver.resolve(HomeTabBarPresenterType.self)!)
        }
    }
    
    func loaded(resolver: Resolver) {
        
    }
}
