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
    var router: DetailRouterType? { get set }
    
    /// Will handle view's primary action.
    func handlePrimaryAction()
}

final class DetailPresenter: DetailPresenterType {
    
    var interactor: DetailInteractorType
    
    // autowired
    weak var router: DetailRouterType?
    
    init(interactor: DetailInteractorType) {
        self.interactor = interactor
    }
    
    func handlePrimaryAction() {
        
    }
}
