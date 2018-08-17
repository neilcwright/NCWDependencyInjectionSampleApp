//
//  TabBarItem1Assembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import Swinject

class TabBarItem1Assembly: Assembly {
    
    func assemble(container: Container) {
        
        // router type
        container.register(TabBarItem1RouterType.self) { resolver in
            return TabBarItem1Router()
        }.initCompleted({ resolver, router in
            router.wireframe = resolver.resolve(WireframeType.self)!
        }).inObjectScope(.weak)
        
        // presenter/router type
        container.register(TabBarItem1PresenterToRouterType.self) { resolver in
            return resolver.resolve(TabBarItem1RouterType.self)!
        }.initCompleted({ resolver, router in
            (router as? TabBarItem1RouterType)?.wireframe = resolver.resolve(WireframeType.self)!
        })
        
        // data manager
        container.register(TabBarItem1DataManagerType.self) { resolver in
            return TabBarItem1DataManager()
        }
        
        // interactor
        container.register(TabBarItem1InteractorType.self) { resolver in
            return TabBarItem1Interactor(dataManager: resolver.resolve(TabBarItem1DataManagerType.self)!)
        }.initCompleted({ resolver, interactor in
            interactor.presenter = resolver.resolve(TabBarItem1InteractorPresenterType.self)!
        })
        
        // presenter
        container.register(TabBarItem1PresenterType.self) { resolver in
            return TabBarItem1Presenter(interactor: resolver.resolve(TabBarItem1InteractorType.self)!)
        }.initCompleted({ resolver, presenter in
            presenter.router = resolver.resolve(TabBarItem1RouterType.self)!
            presenter.view = resolver.resolve(TabBarItem1PresenterToViewType.self)!
        })
        
        // presenter->view type
        container.register(TabBarItem1PresenterToViewType.self) { resolver in
            let viewController = resolver.resolve(TabBarItem1ViewControllerType.self)!
            return viewController as! TabBarItem1PresenterToViewType
        }
        
        // interactor->presenter type
        container.register(TabBarItem1InteractorPresenterType.self) { resolver in
            let presenter = resolver.resolve(TabBarItem1PresenterType.self)!
            return presenter as! TabBarItem1InteractorPresenterType
        }
        
        // view controller
        container.register(TabBarItem1ViewControllerType.self) { resolver in
            return TabBarItem1ViewController(presenter: resolver.resolve(TabBarItem1PresenterType.self)!)
        }
    }
    
    func loaded(resolver: Resolver) {
        
    }
}
