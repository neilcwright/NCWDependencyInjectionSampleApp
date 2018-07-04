//
//  LoginAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-01-2018.
//

import Swinject

class LoginAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // router type
        container.register(LoginRouterType.self) { resolver in
            return LoginRouter()
        }.initCompleted({ resolver, router in
            router.routeProvider = resolver.resolve(RouteProviderType.self)!
        }).inObjectScope(.weak)
        
        // presenter/router type
        container.register(LoginPresenterToRouterType.self) { resolver in
            return resolver.resolve(LoginRouterType.self)!
        }.initCompleted({ resolver, router in
            (router as? LoginRouterType)?.routeProvider = resolver.resolve(RouteProviderType.self)!
        })
        
        // data manager
        container.register(LoginDataManagerType.self) { resolver in
            let accountService = resolver.resolve(AccountServiceType.self)!
            return LoginDataManager(accountService: accountService)
        }
        
        // interactor
        container.register(LoginInteractorType.self) { resolver in
            return LoginInteractor(dataManager: resolver.resolve(LoginDataManagerType.self)!)
        }.initCompleted({ resolver, interactor in
            interactor.presenter = resolver.resolve(LoginInteractorPresenterType.self)!
        })
        
        // presenter
        container.register(LoginPresenterType.self) { resolver in
            return LoginPresenter(interactor: resolver.resolve(LoginInteractorType.self)!)
        }.initCompleted({ resolver, presenter in
            presenter.router = resolver.resolve(LoginRouterType.self)!
            presenter.view = resolver.resolve(LoginPresenterToViewType.self)!
        })
        
        // presenter->view type
        container.register(LoginPresenterToViewType.self) { resolver in
            let viewController = resolver.resolve(LoginViewControllerType.self)!
            return viewController as! LoginPresenterToViewType
        }
        
        // interactor->presenter type
        container.register(LoginInteractorPresenterType.self) { resolver in
            let presenter = resolver.resolve(LoginPresenterType.self)!
            return presenter as! LoginInteractorPresenterType
        }
        
        // view controller
        container.register(LoginViewControllerType.self) { resolver in
            return LoginViewController(presenter: resolver.resolve(LoginPresenterType.self)!)
        }
    }
    
    func loaded(resolver: Resolver) {
        
    }
}
