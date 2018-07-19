//
//  HomeTabBarPresenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

// View->Presenter interface.
protocol HomeTabBarPresenterType: class {
    
    var interactor: HomeTabBarInteractorType { get set }
    var router: HomeTabBarPresenterToRouterType? { get set }
    var view: HomeTabBarPresenterToViewType? { get set }
}

// Presenter->View interface for calling view.
protocol HomeTabBarPresenterToViewType: class {
    
}

final class HomeTabBarPresenter: HomeTabBarPresenterType {
    
    var interactor: HomeTabBarInteractorType
    var router: HomeTabBarPresenterToRouterType?
    weak var view: HomeTabBarPresenterToViewType?
    
    init(interactor: HomeTabBarInteractorType) {
        self.interactor = interactor
    }
    
    deinit {
        print("HomeTabBar presenter deinit")
    }
}

// (Outbound) Interface for receiving the interactor's events.
extension HomeTabBarPresenter: HomeTabBarInteractorPresenterType {
    
}
