//
//  TabBarItem3Presenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

// View->Presenter interface.
protocol TabBarItem3PresenterType: class {
    
    var interactor: TabBarItem3InteractorType { get set }
    var router: TabBarItem3PresenterToRouterType? { get set }
    var view: TabBarItem3PresenterToViewType? { get set }
    
    /// Will inform presenter that primary action in view has been triggered.
    func handlePrimaryAction()
}

// Presenter->View interface for calling view.
protocol TabBarItem3PresenterToViewType: class {

}

final class TabBarItem3Presenter: TabBarItem3PresenterType {
    
    var interactor: TabBarItem3InteractorType
    var router: TabBarItem3PresenterToRouterType?
    weak var view: TabBarItem3PresenterToViewType?
    
    init(interactor: TabBarItem3InteractorType) {
        self.interactor = interactor
    }
    
    deinit {
        print("TabBarItem3 presenter deinit")
    }
    
    func handlePrimaryAction() {
        self.router?.dismissBackToRootRoute()
    }
}

// (Outbound) Interface for receiving the interactor's events.
extension TabBarItem3Presenter: TabBarItem3InteractorPresenterType {
    
}
