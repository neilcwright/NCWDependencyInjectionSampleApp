//
//  TabBarItem1Presenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

// View->Presenter interface.
protocol TabBarItem1PresenterType: class {
    
    var interactor: TabBarItem1InteractorType { get set }
    var router: TabBarItem1PresenterToRouterType? { get set }
    var view: TabBarItem1PresenterToViewType? { get set }
}

// Presenter->View interface for calling view.
protocol TabBarItem1PresenterToViewType: class {
    
}

final class TabBarItem1Presenter: TabBarItem1PresenterType {
    
    var interactor: TabBarItem1InteractorType
    var router: TabBarItem1PresenterToRouterType?
    weak var view: TabBarItem1PresenterToViewType?
    
    init(interactor: TabBarItem1InteractorType) {
        self.interactor = interactor
    }
    
    deinit {
        print("TabBarItem1 presenter deinit")
    }
}

// (Outbound) Interface for receiving the interactor's events.
extension TabBarItem1Presenter: TabBarItem1InteractorPresenterType {
    
}
