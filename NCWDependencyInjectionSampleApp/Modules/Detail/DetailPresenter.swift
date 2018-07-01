//
//  DetailPresenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

// MARK: Protocols

protocol DetailPresenterType: class {
    
    // hold strongly
    var interactor: DetailInteractorType { get set }
    // hold strongly
    var router: DetailRouterType! { get set }
    // hold weakly
    var view: DetailPresenterToViewType? { get set }

    /// Will handle view's primary action.
    func handlePrimaryAction()
}

protocol DetailPresenterToViewType: class {
    
}

final class DetailPresenter: DetailPresenterType, DetailPresenterToViewType {
    
    var interactor: DetailInteractorType
    var router: DetailRouterType!
    weak var view: DetailPresenterToViewType?
    
    init(interactor: DetailInteractorType) {
        self.interactor = interactor
    }
    
    func handlePrimaryAction() {
        self.router?.routeToAlert()
    }
}
