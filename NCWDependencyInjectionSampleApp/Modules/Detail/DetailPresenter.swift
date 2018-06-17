//
//  DetailPresenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

protocol DetailPresenterType: class {
    var interactor: DetailInteractorType! { get set }
}

final class DetailPresenter: DetailPresenterType {
    var interactor: DetailInteractorType!
}
