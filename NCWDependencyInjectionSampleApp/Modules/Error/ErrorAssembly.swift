//
//  ErrorAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-03-2018.
//

import Swinject

class ErrorAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // router type
        container.register(ErrorRouterType.self) { resolver in
            return ErrorRouter()
        }.initCompleted({ resolver, router in
            router.wireframe = resolver.resolve(WireframeType.self)!
        }).inObjectScope(.weak)
        
        // presenter/router type
        container.register(ErrorPresenterToRouterType.self) { resolver in
            return resolver.resolve(ErrorRouterType.self)!
        }.initCompleted({ resolver, router in
            (router as? ErrorRouterType)?.wireframe = resolver.resolve(WireframeType.self)!
        })
        
        // data manager
        container.register(ErrorDataManagerType.self) { resolver in
            return ErrorDataManager()
        }
        
        // interactor
        container.register(ErrorInteractorType.self) { resolver in
            return ErrorInteractor(dataManager: resolver.resolve(ErrorDataManagerType.self)!)
        }.initCompleted({ resolver, interactor in
            interactor.presenter = resolver.resolve(ErrorInteractorPresenterType.self)!
        })
        
        // presenter
        container.register(ErrorPresenterType.self) { resolver in
            return ErrorPresenter(interactor: resolver.resolve(ErrorInteractorType.self)!)
        }.initCompleted({ resolver, presenter in
            presenter.router = resolver.resolve(ErrorRouterType.self)!
            presenter.view = resolver.resolve(ErrorPresenterToViewType.self)!
        })
        
        // presenter->view type
        container.register(ErrorPresenterToViewType.self) { resolver in
            let viewController = resolver.resolve(ErrorViewControllerType.self)!
            return viewController as! ErrorPresenterToViewType
        }
        
        // interactor->presenter type
        container.register(ErrorInteractorPresenterType.self) { resolver in
            let presenter = resolver.resolve(ErrorPresenterType.self)!
            return presenter as! ErrorInteractorPresenterType
        }
        
        // view controller
        container.register(ErrorViewControllerType.self) { resolver in
            return ErrorViewController(presenter: resolver.resolve(ErrorPresenterType.self)!)
        }
    }
    
    func loaded(resolver: Resolver) {
        
    }
}
