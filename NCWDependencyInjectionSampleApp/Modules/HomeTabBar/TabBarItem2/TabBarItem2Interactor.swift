//
//  TabBarItem2Interactor.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

// inbound protocol interface
protocol TabBarItem2InteractorType: class {
    // held strongly
    var dataManager: TabBarItem2DataManagerType { get set }
    
    // held weakly (is owned by)
    var presenter: TabBarItem2InteractorPresenterType? { get set }
}

// outbound protocol interface
protocol TabBarItem2InteractorPresenterType: class {

}

final class TabBarItem2Interactor: TabBarItem2InteractorType {
    
    var dataManager: TabBarItem2DataManagerType
    weak var presenter: TabBarItem2InteractorPresenterType?
    
    init(dataManager: TabBarItem2DataManagerType) {
        self.dataManager = dataManager
    }
    
    deinit {
        print("TabBarItem2 interactor deinit")
    }
}
