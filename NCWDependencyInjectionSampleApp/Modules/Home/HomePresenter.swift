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
    var router: HomePresenterRouterType? { get set }
}

// Outbound protocol
protocol HomePresenterRouterType: class {
    
}

final class HomePresenter: HomePresenterType, HomePresenterRouterType {
    
    var interactor: HomeInteractorType
    weak var router: HomePresenterRouterType?
    
    init(interactor: HomeInteractorType) {
        self.interactor = interactor
    }
}
