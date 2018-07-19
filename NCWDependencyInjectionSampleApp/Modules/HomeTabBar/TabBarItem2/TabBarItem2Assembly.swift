//
//  TabBarItem2Assembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import Swinject

class TabBarItem2Assembly: Assembly {
    
    func assemble(container: Container) {
        
        // router type
        container.register(TabBarItem2RouterType.self) { resolver in
            return TabBarItem2Router()
        }.initCompleted({ resolver, router in
            router.appRouter = resolver.resolve(AppRouterType.self)!
        }).inObjectScope(.weak)
        
        // presenter/router type
        container.register(TabBarItem2PresenterToRouterType.self) { resolver in
            return resolver.resolve(TabBarItem2RouterType.self)!
        }.initCompleted({ resolver, router in
            (router as? TabBarItem2RouterType)?.appRouter = resolver.resolve(AppRouterType.self)!
        })
        
        // data manager
        container.register(TabBarItem2DataManagerType.self) { resolver in
            return TabBarItem2DataManager()
        }
        
        // interactor
        container.register(TabBarItem2InteractorType.self) { resolver in
            return TabBarItem2Interactor(dataManager: resolver.resolve(TabBarItem2DataManagerType.self)!)
        }.initCompleted({ resolver, interactor in
            interactor.presenter = resolver.resolve(TabBarItem2InteractorPresenterType.self)!
        })
        
        // presenter
        container.register(TabBarItem2PresenterType.self) { resolver in
            return TabBarItem2Presenter(interactor: resolver.resolve(TabBarItem2InteractorType.self)!)
        }.initCompleted({ resolver, presenter in
            presenter.router = resolver.resolve(TabBarItem2RouterType.self)!
            presenter.view = resolver.resolve(TabBarItem2PresenterToViewType.self)!
        })
        
        // presenter->view type
        container.register(TabBarItem2PresenterToViewType.self) { resolver in
            let viewController = resolver.resolve(TabBarItem2ViewControllerType.self)!
            return viewController as! TabBarItem2PresenterToViewType
        }
        
        // interactor->presenter type
        container.register(TabBarItem2InteractorPresenterType.self) { resolver in
            let presenter = resolver.resolve(TabBarItem2PresenterType.self)!
            return presenter as! TabBarItem2InteractorPresenterType
        }
        
        // view controller
        container.register(TabBarItem2ViewControllerType.self) { resolver in
            return TabBarItem2ViewController(presenter: resolver.resolve(TabBarItem2PresenterType.self)!)
        }
    }
    
    func loaded(resolver: Resolver) {
        
    }
}
