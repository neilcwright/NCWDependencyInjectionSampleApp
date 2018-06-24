//
//  HomePresenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

// Inbound protocol
protocol HomePresenterType: class {
    
    // hold strong
    var interactor: HomeInteractorType { get set }
    
    // hold weak
    var router: HomeRouterType? { get set }
    
    /// Will handle the primary action triggered from the home view controller.
    ///
    /// - Parameter viewController: the interface for communicating from presenter to view.
    func handlePrimaryAction(_ viewController: HomePresenterViewType)
}

// Presenter->Router protocol

protocol HomePresenterViewType: class {
    
}

final class HomePresenter: HomePresenterType {
    
    var interactor: HomeInteractorType
    weak var router: HomeRouterType?
    
    init(interactor: HomeInteractorType) {
        self.interactor = interactor
    }
    
    func handlePrimaryAction(_ viewController: HomePresenterViewType) {
        self.router?.routeToDetailView()
    }
}
