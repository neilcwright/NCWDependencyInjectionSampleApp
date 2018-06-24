//
//  DetailInteractor.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

protocol DetailInteractorType: class {
    var dataManager: DetailDataManagerType { get set }
}

final class DetailInteractor: DetailInteractorType {
    var dataManager: DetailDataManagerType
    
    init(dataManager: DetailDataManagerType) {
        self.dataManager = dataManager
    }
}
