//
//  CollapsedPreviewView.swift
//  CollapsableCell
//
//  Created by Mohamed Marbouh on 2019-09-27.
//  Copyright © 2019 Mohamed Marbouh. All rights reserved.
//

import UIKit

class CollapsedPreviewView: UIView, CardCell {

    let indexLabel = UILabel()
    let addressView = CollapsedAddressView()
    let requestsView = InfoView()
    let pledgeView = InfoView()
    let weightView = InfoView()
    
    var date = Date() {
        didSet {
            updateDateView()
        }
    }
    
    private let ribbonView = UIView()
    private let dateView = InfoView()
    private let stackView = UIStackView()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        applyRoundedCorners()
        
        setupRibbonView()
        setupAddressView()
        setupStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with card: Card) {
        indexLabel.text = String(card.position)
        date = card.delivery
        addressView.originLabel.text = card.origin
        addressView.destinationLabel.text = card.destination
        requestsView.bottomLabel.text = String(card.requests)
        pledgeView.bottomLabel.text = "$\(card.pledge)"
        weightView.bottomLabel.text = card.weight
    }
    
}

// Ribbon

extension CollapsedPreviewView {
    
    private func setupRibbonView() {
        ribbonView.backgroundColor = .purple
        ribbonView.makeAutoLayout()
        
        indexLabel.font = .systemFont(ofSize: FontConstants.index)
        indexLabel.makeAutoLayout()
        indexLabel.textColor = .white
        
        dateView.topLabel.textAlignment = .center
        dateView.bottomLabel.textAlignment = .center
        dateView.bottomLabel.textColor = .white
        dateView.makeAutoLayout()
        
        addSubview(ribbonView)
        ribbonView.addSubview(indexLabel)
        ribbonView.addSubview(dateView)
        
        dateView.constrainByWidth()
        
        NSLayoutConstraint.activate([
            ribbonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ribbonView.widthAnchor.constraint(equalToConstant: ViewConstants.rowDimension*2),
            ribbonView.topAnchor.constraint(equalTo: topAnchor),
            ribbonView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            indexLabel.centerXAnchor.constraint(equalTo: ribbonView.centerXAnchor),
            indexLabel.topAnchor.constraint(equalTo: ribbonView.topAnchor, constant: ViewConstants.padding*2),
            
            dateView.bottomAnchor.constraint(equalTo: ribbonView.bottomAnchor, constant: -ViewConstants.padding)
        ])
    }
    
    private func updateDateView() {
        let topFormatter = DateFormatter()
        topFormatter.doesRelativeDateFormatting = true
        topFormatter.dateStyle = .short
        topFormatter.timeStyle = .none
        dateView.topLabel.text = topFormatter.string(from: date)
        
        let bottomFormatter = DateFormatter()
        bottomFormatter.dateStyle = .none
        bottomFormatter.timeStyle = .short
        dateView.bottomLabel.text = bottomFormatter.string(from: date)
    }
    
}

// Address

extension CollapsedPreviewView {
    
    private func setupAddressView() {
        addressView.makeAutoLayout()
        
        addSubview(addressView)
        
        NSLayoutConstraint.activate([
            addressView.leadingAnchor.constraint(equalTo: ribbonView.trailingAnchor, constant: ViewConstants.padding*3),
            addressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewConstants.padding),
            addressView.topAnchor.constraint(equalTo: indexLabel.topAnchor)
        ])
    }
    
}

// Stack view

extension CollapsedPreviewView {
    
    private func setupStackView() {
        requestsView.topLabel.text = "REQUESTS"
        pledgeView.topLabel.text = "PLEDGE"
        weightView.topLabel.text = "WEIGHT"
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.makeAutoLayout()
        stackView.spacing = ViewConstants.padding*2
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(requestsView)
        stackView.addArrangedSubview(pledgeView)
        stackView.addArrangedSubview(weightView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: ribbonView.trailingAnchor, constant: ViewConstants.padding*3),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewConstants.padding*3),
            stackView.topAnchor.constraint(equalTo: addressView.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewConstants.padding)
        ])
    }
    
}
