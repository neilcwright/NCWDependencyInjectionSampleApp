//
//  TabBarItem3Assembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import Swinject

class TabBarItem3Assembly: Assembly {
    
    func assemble(container: Container) {
        
        // router type
        container.register(TabBarItem3RouterType.self) { resolver in
            return TabBarItem3Router()
        }.initCompleted({ resolver, router in
            router.wireframe = resolver.resolve(WireframeType.self)!
        }).inObjectScope(.weak)
        
        // presenter/router type
        container.register(TabBarItem3PresenterToRouterType.self) { resolver in
            return resolver.resolve(TabBarItem3RouterType.self)!
        }.initCompleted({ resolver, router in
            (router as? TabBarItem3RouterType)?.wireframe = resolver.resolve(WireframeType.self)!
        })
        
        // data manager
        container.register(TabBarItem3DataManagerType.self) { resolver in
            return TabBarItem3DataManager()
        }
        
        // interactor
        container.register(TabBarItem3InteractorType.self) { resolver in
            return TabBarItem3Interactor(dataManager: resolver.resolve(TabBarItem3DataManagerType.self)!)
        }.initCompleted({ resolver, interactor in
            interactor.presenter = resolver.resolve(TabBarItem3InteractorPresenterType.self)!
        })
        
        // presenter
        container.register(TabBarItem3PresenterType.self) { resolver in
            return TabBarItem3Presenter(interactor: resolver.resolve(TabBarItem3InteractorType.self)!)
        }.initCompleted({ resolver, presenter in
            presenter.router = resolver.resolve(TabBarItem3RouterType.self)!
            presenter.view = resolver.resolve(TabBarItem3PresenterToViewType.self)!
        })
        
        // presenter->view type
        container.register(TabBarItem3PresenterToViewType.self) { resolver in
            let viewController = resolver.resolve(TabBarItem3ViewControllerType.self)!
            return viewController as! TabBarItem3PresenterToViewType
        }
        
        // interactor->presenter type
        container.register(TabBarItem3InteractorPresenterType.self) { resolver in
            let presenter = resolver.resolve(TabBarItem3PresenterType.self)!
            return presenter as! TabBarItem3InteractorPresenterType
        }
        
        // view controller
        container.register(TabBarItem3ViewControllerType.self) { resolver in
            return TabBarItem3ViewController(presenter: resolver.resolve(TabBarItem3PresenterType.self)!)
        }
    }
    
    func loaded(resolver: Resolver) {
        
    }
}
