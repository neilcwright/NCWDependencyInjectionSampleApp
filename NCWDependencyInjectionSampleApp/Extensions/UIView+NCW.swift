//
//  UIView+NCW.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 8/21/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//
import UIKit

extension UIView {
    
    /// Will return scroll view instance with inner content view.
    ///
    /// - Returns: a tuple containing the scroll view and the content view that is its one and only child.
    func addScrollViewWithContentView() -> (UIScrollView, UIView) {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
       
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        return (scrollView, contentView)
    }
}
