//
//  DetailPresenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

protocol DetailPresenterType: class {
    // hold strongly
    var interactor: DetailInteractorType { get set }
    
    // hold weakly
    var router: DetailPresenterRouterType? { get set }
}

protocol DetailPresenterRouterType: class {
    func routeToHome()
}

final class DetailPresenter: DetailPresenterType {
    var interactor: DetailInteractorType
    
    init(interactor: DetailInteractorType) {
        self.interactor = interactor
    }
    
    var router: DetailPresenterRouterType?
}
