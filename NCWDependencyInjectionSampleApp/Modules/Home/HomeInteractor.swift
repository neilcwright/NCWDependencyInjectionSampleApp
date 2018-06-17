//
//  HomeInteractor.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

// inbound protocol interface
protocol HomeInteractorType: class {
    var dataManager: HomeDataManagerType! { get set }
}

// outbound protocol interface
protocol HomeInteractorDelegate: class {
    
}

final class HomeInteractor: HomeInteractorType {
    var dataManager: HomeDataManagerType!
}
