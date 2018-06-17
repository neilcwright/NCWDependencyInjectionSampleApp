//
//  DetailAssembly.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Swinject

class DetailAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // data manager
        container.register(DetailDataManagerType.self) {
            resolver in
            return DetailDataManager(exampleService: resolver.resolve(ExampleServiceType.self)!)
        }.initCompleted({
            resolver, dataManager in
            
            print("detail data manager initialized")
        }).inObjectScope(.graph)
        
        // interactor
        container.register(DetailInteractorType.self) {
            resolver in
            return DetailInteractor()
        }.initCompleted({
            resolver, interactor in
            
            interactor.dataManager = resolver.resolve(DetailDataManagerType.self)!
            print("detail interactor initialized")
        }).inObjectScope(.graph)
        
        // presenter
        container.register(DetailPresenterType.self) {
            resolver in
            return DetailPresenter()
        }.initCompleted({
            resolver, presenter in
            
            presenter.interactor = resolver.resolve(DetailInteractorType.self)!
            print("detail presenter initialized")
        }).inObjectScope(.graph)
        
        // view controller
        container.register(DetailViewControllerType.self) {
            resolver in
            return DetailViewController()
        }.initCompleted({
            resolver, viewController in

            print("detail view controller initialized")
        }).inObjectScope(.graph)
    }
    
    func loaded(resolver: Resolver) {
        print("detail assembly loaded")
    }
}
