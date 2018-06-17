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
    
    var interactor: HomeInteractorType! { get set }
}

// Outbound protocol
protocol HomePresenterDelegateType: class {
    
}

final class HomePresenter: HomePresenterType {
    
    var interactor: HomeInteractorType!
    
}
