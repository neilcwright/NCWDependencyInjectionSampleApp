//
//  CreateAccountAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-08-2018.
//

import Swinject

class CreateAccountAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // router type
        container.register(CreateAccountRouterType.self) { resolver in
            return CreateAccountRouter()
        }.initCompleted({ resolver, router in
            router.wireframe = resolver.resolve(WireframeType.self)!
        }).inObjectScope(.weak)
        
        // presenter/router type
        container.register(CreateAccountPresenterToRouterType.self) { resolver in
            return resolver.resolve(CreateAccountRouterType.self)!
        }.initCompleted({ resolver, router in
            (router as? CreateAccountRouterType)?.wireframe = resolver.resolve(WireframeType.self)!
        })
        
        // data manager
        container.register(CreateAccountDataManagerType.self) { resolver in
            return CreateAccountDataManager(accountService: resolver.resolve(AccountServiceType.self)!)
        }
        
        // interactor
        container.register(CreateAccountInteractorType.self) { resolver in
            return CreateAccountInteractor(dataManager: resolver.resolve(CreateAccountDataManagerType.self)!)
        }.initCompleted({ resolver, interactor in
            interactor.presenter = resolver.resolve(CreateAccountInteractorPresenterType.self)!
        })
        
        // presenter
        container.register(CreateAccountPresenterType.self) { resolver in
            return CreateAccountPresenter(interactor: resolver.resolve(CreateAccountInteractorType.self)!)
        }.initCompleted({ resolver, presenter in
            presenter.router = resolver.resolve(CreateAccountRouterType.self)!
            presenter.view = resolver.resolve(CreateAccountPresenterToViewType.self)!
        })
        
        // presenter->view type
        container.register(CreateAccountPresenterToViewType.self) { resolver in
            let viewController = resolver.resolve(CreateAccountViewControllerType.self)!
            return viewController as! CreateAccountPresenterToViewType
        }
        
        // interactor->presenter type
        container.register(CreateAccountInteractorPresenterType.self) { resolver in
            let presenter = resolver.resolve(CreateAccountPresenterType.self)!
            return presenter as! CreateAccountInteractorPresenterType
        }
        
        // view controller
        container.register(CreateAccountViewControllerType.self) { resolver in
            return CreateAccountViewController(presenter: resolver.resolve(CreateAccountPresenterType.self)!)
        }
    }
    
    func loaded(resolver: Resolver) {
        
    }
}
