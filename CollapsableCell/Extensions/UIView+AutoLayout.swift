//
//  UIView+AutoLayout.swift
//  CollapsableCell
//
//  Created by Mohamed Marbouh on 2019-09-27.
//  Copyright © 2019 Mohamed Marbouh. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyRoundedCorners() {
        layer.cornerRadius = ViewConstants.cornerRadius
        layer.masksToBounds = true
    }
    
    func makeAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func constrain(to otherView: UIView? = nil, constant: CGFloat = 0) {
        let temp = otherView ?? superview
        let inverseConstant: CGFloat = -constant
        
        if let secondItem = temp {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: secondItem.leadingAnchor, constant: constant),
                trailingAnchor.constraint(equalTo: secondItem.trailingAnchor, constant: inverseConstant),
                topAnchor.constraint(equalTo: secondItem.topAnchor, constant: constant),
                bottomAnchor.constraint(equalTo: secondItem.bottomAnchor, constant: inverseConstant)
            ])
        }
    }
    
    func constrainByWidth(_ padding: CGFloat = 0) {
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding)
        ])
    }
    
}
