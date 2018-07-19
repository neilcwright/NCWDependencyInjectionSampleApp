//
//  TabBarItem2Presenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

// View->Presenter interface.
protocol TabBarItem2PresenterType: class {
    
    var interactor: TabBarItem2InteractorType { get set }
    var router: TabBarItem2PresenterToRouterType? { get set }
    var view: TabBarItem2PresenterToViewType? { get set }
}

// Presenter->View interface for calling view.
protocol TabBarItem2PresenterToViewType: class {
    
}

final class TabBarItem2Presenter: TabBarItem2PresenterType {
    
    var interactor: TabBarItem2InteractorType
    var router: TabBarItem2PresenterToRouterType?
    weak var view: TabBarItem2PresenterToViewType?
    
    init(interactor: TabBarItem2InteractorType) {
        self.interactor = interactor
    }
    
    deinit {
        print("TabBarItem2 presenter deinit")
    }
}

// (Outbound) Interface for receiving the interactor's events.
extension TabBarItem2Presenter: TabBarItem2InteractorPresenterType {
    
}
