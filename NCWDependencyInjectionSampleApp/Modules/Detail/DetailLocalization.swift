//
//  DetailLocalization.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/24/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

fileprivate let tableName = "Detail"

struct DetailLocalization {
    
    static var titleText: String { return "detail.view.title.text".localized(tableName: tableName) }
    
    static var descriptionText: String {
        return "detail.view.description.text".localized(tableName: tableName)
    }
    
    static var primaryButtonText: String {
        return "detail.view.primary.button.text".localized(tableName: tableName)
    }
}
