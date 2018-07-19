//
//  HomeTabBarInteractor.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

// inbound protocol interface
protocol HomeTabBarInteractorType: class {
    // held strongly
    var dataManager: HomeTabBarDataManagerType { get set }
    
    // held weakly (is owned by)
    var presenter: HomeTabBarInteractorPresenterType? { get set }
}

// outbound protocol interface
protocol HomeTabBarInteractorPresenterType: class {

}

final class HomeTabBarInteractor: HomeTabBarInteractorType {
    
    var dataManager: HomeTabBarDataManagerType
    weak var presenter: HomeTabBarInteractorPresenterType?
    
    init(dataManager: HomeTabBarDataManagerType) {
        self.dataManager = dataManager
    }
    
    deinit {
        print("HomeTabBar interactor deinit")
    }
}
