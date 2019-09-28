//
//  CollapsedAddressView.swift
//  CollapsableCell
//
//  Created by Mohamed Marbouh on 2019-09-27.
//  Copyright © 2019 Mohamed Marbouh. All rights reserved.
//

import UIKit

class CollapsedAddressView: UIView {

    let originLabel = UILabel()
    let destinationLabel = UILabel()
    
    private let separatorView = SeparatorView()
    
    init() {
        super.init(frame: .zero)
        
        configureLabel(originLabel)
        configureLabel(destinationLabel)
        
        addSubview(originLabel)
        addSubview(destinationLabel)
        addSubview(separatorView)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel(_ label: UILabel) {
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.makeAutoLayout()
        label.textAlignment = .right
    }
    
    private func configureConstraints() {
        originLabel.constrainByWidth()
        separatorView.constrainByWidth()
        destinationLabel.constrainByWidth()
        
        NSLayoutConstraint.activate([
            originLabel.topAnchor.constraint(equalTo: topAnchor),
            separatorView.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: ViewConstants.padding/2),
            destinationLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: ViewConstants.padding/2)
        ])
    }
    
}
