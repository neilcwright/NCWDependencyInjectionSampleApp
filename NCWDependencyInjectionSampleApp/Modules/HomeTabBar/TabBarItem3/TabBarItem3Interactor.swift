//
//  TabBarItem3Interactor.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

// inbound protocol interface
protocol TabBarItem3InteractorType: class {
    // held strongly
    var dataManager: TabBarItem3DataManagerType { get set }
    
    // held weakly (is owned by)
    var presenter: TabBarItem3InteractorPresenterType? { get set }
}

// outbound protocol interface
protocol TabBarItem3InteractorPresenterType: class {

}

final class TabBarItem3Interactor: TabBarItem3InteractorType {
    
    var dataManager: TabBarItem3DataManagerType
    weak var presenter: TabBarItem3InteractorPresenterType?
    
    init(dataManager: TabBarItem3DataManagerType) {
        self.dataManager = dataManager
    }
    
    deinit {
        print("TabBarItem3 interactor deinit")
    }
}
