//
//  HomeTabBarLocalization.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import Foundation

fileprivate let tableName = "HomeTabBar"
struct HomeTabBarLocalization {

    static var tabBarItem1: String {
        return "home.tab.bar.view.tab.item.1.title".localized(tableName: tableName)
    }
    
    static var tabBarItem2: String {
        return "home.tab.bar.view.tab.item.1.title".localized(tableName: tableName)
    }
}
