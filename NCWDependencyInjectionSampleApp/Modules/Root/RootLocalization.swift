//
//  RootLocalization.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/24/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

fileprivate let tableName = "Root"
struct RootLocalization {
    
    static var titleText: String {
        return "root.view.title.text".localized(tableName: tableName)
    }
}
