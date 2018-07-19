//
//  TabBarItem1Interactor.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

// inbound protocol interface
protocol TabBarItem1InteractorType: class {
    // held strongly
    var dataManager: TabBarItem1DataManagerType { get set }
    
    // held weakly (is owned by)
    var presenter: TabBarItem1InteractorPresenterType? { get set }
}

// outbound protocol interface
protocol TabBarItem1InteractorPresenterType: class {

}

final class TabBarItem1Interactor: TabBarItem1InteractorType {
    
    var dataManager: TabBarItem1DataManagerType
    weak var presenter: TabBarItem1InteractorPresenterType?
    
    init(dataManager: TabBarItem1DataManagerType) {
        self.dataManager = dataManager
    }
    
    deinit {
        print("TabBarItem1 interactor deinit")
    }
}
