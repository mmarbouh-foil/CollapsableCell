//
//  ExpandedCellView.swift
//  CollapsableCell
//
//  Created by Mohamed Marbouh on 2019-09-27.
//  Copyright © 2019 Mohamed Marbouh. All rights reserved.
//

import UIKit

class ExpandedCellView: UIView, CardCell {

    private let indexLabel = UILabel()
    private let priceLabel = UILabel()
    private let requestsView = InfoView()
    private let pledgeView = InfoView()
    private let weightView = InfoView()
    private let senderImageView = UIImageView()
    private let senderNameLabel = UILabel()
    private let addressView = ExpandedInfoView()
    private let deliveryView = ExpandedInfoView()
    
    private let ribbonView = UIView()
    private let headerImageView = UIImageView()
    private let requestsLabel = UILabel()
    
    private let senderContainerView = UIView()
    private let infoViewsContainerView = UIView()
    private let requestButtonContainerview = UIView()
    
    var deliveryDate = Date() {
        didSet {
            updateDeliveryDate()
        }
    }
    
    var deadlineDate = Date() {
        didSet {
            updateDeadlineDate()
        }
    }
    
    var amountOfRequests = 0 {
        didSet {
            updateRequestsLabel()
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        applyRoundedCorners()
        
        setupRibbonView()
        setupHeaderView()
        setupSenderContainerView()
        setupInfoViewsContainerView()
        setupRequestButtonContainerview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with card: Card) {
        indexLabel.text = String(card.position)
        priceLabel.text = "$\(card.price)"
        requestsView.bottomLabel.text = String(card.requests)
        pledgeView.bottomLabel.text = "$\(card.pledge)"
        weightView.bottomLabel.text = card.weight
        senderImageView.image = UIImage(named: card.profileImage)
        senderNameLabel.text = card.sender
        addressView.leftView.bottomLabel.text = card.origin
        addressView.rightView.bottomLabel.text = card.destination
        deliveryDate = card.delivery
        deadlineDate = card.deadline
        amountOfRequests = card.amountOfRequests
    }
    
}

// Ribbon

extension ExpandedCellView {
    
    private func setupRibbonView() {
        ribbonView.backgroundColor = .purple
        ribbonView.makeAutoLayout()
        
        configureRibbonLabel(indexLabel)
        configureRibbonLabel(priceLabel)
        
        addSubview(ribbonView)
        ribbonView.addSubview(indexLabel)
        ribbonView.addSubview(priceLabel)
        
        ribbonView.constrainByWidth()
        
        NSLayoutConstraint.activate([
            ribbonView.topAnchor.constraint(equalTo: topAnchor),
            ribbonView.heightAnchor.constraint(equalToConstant: ViewConstants.rowDimension),
            
            indexLabel.centerXAnchor.constraint(equalTo: ribbonView.centerXAnchor),
            indexLabel.centerYAnchor.constraint(equalTo: ribbonView.centerYAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: ribbonView.trailingAnchor, constant: -ViewConstants.padding),
            priceLabel.centerYAnchor.constraint(equalTo: ribbonView.centerYAnchor)
        ])
    }
    
    private func configureRibbonLabel(_ label: UILabel) {
        label.font = .systemFont(ofSize: FontConstants.index)
        label.makeAutoLayout()
        label.textColor = .white
    }

}

// Header

extension ExpandedCellView {
    
    private func setupHeaderView() {
        headerImageView.image = UIImage(named: "Decanter")
        headerImageView.makeAutoLayout()
        
        configureHeaderInfoViews()
        
        addSubview(headerImageView)
        headerImageView.addSubview(requestsView)
        headerImageView.addSubview(pledgeView)
        headerImageView.addSubview(weightView)
        
        headerImageView.constrainByWidth()
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: ribbonView.bottomAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: ViewConstants.rowDimension*3),
            
            requestsView.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor, constant: ViewConstants.padding),
            requestsView.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor),
            
            pledgeView.centerXAnchor.constraint(equalTo: headerImageView.centerXAnchor),
            pledgeView.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor),
            
            weightView.trailingAnchor.constraint(equalTo: headerImageView.trailingAnchor, constant: -ViewConstants.padding),
            weightView.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor)
        ])
    }
    
    private func configureHeaderInfoViews() {
        requestsView.makeAutoLayout()
        requestsView.setTextColour(.white)
        requestsView.topLabel.text = "REQUESTS"
        
        pledgeView.makeAutoLayout()
        pledgeView.setTextColour(.white)
        pledgeView.topLabel.text = "PLEDGE"
        
        weightView.makeAutoLayout()
        weightView.setTextColour(.white)
        weightView.topLabel.text = "WEIGHT"
    }
    
}

// Sender

extension ExpandedCellView {
    
    private func setupSenderContainerView() {
        let separatorView = SeparatorView()
        let senderLabel = UILabel()
        
        configureSenderViews(senderLabel)
        
        addSubview(senderContainerView)
        senderContainerView.addSubview(senderLabel)
        senderContainerView.addSubview(senderImageView)
        senderContainerView.addSubview(senderNameLabel)
        senderContainerView.addSubview(separatorView)
        
        senderContainerView.constrainByWidth()
        separatorView.constrainByWidth(ViewConstants.margin)
        
        NSLayoutConstraint.activate([
            senderContainerView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor),
            senderContainerView.heightAnchor.constraint(equalToConstant: ViewConstants.profileDimension+ViewConstants.rowDimension),
            
            senderLabel.leadingAnchor.constraint(equalTo: senderContainerView.leadingAnchor, constant: ViewConstants.margin),
            senderLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: ViewConstants.padding),
            
            senderImageView.leadingAnchor.constraint(equalTo: senderContainerView.leadingAnchor, constant: ViewConstants.margin),
            senderImageView.topAnchor.constraint(equalTo: senderLabel.bottomAnchor, constant: ViewConstants.padding/2),
            senderImageView.widthAnchor.constraint(equalTo: senderImageView.heightAnchor),
            senderImageView.heightAnchor.constraint(equalToConstant: ViewConstants.profileDimension),
            
            senderNameLabel.leadingAnchor.constraint(equalTo: senderImageView.trailingAnchor, constant: ViewConstants.padding/2),
            senderNameLabel.trailingAnchor.constraint(equalTo: senderContainerView.trailingAnchor),
            senderNameLabel.topAnchor.constraint(equalTo: senderImageView.topAnchor, constant: ViewConstants.padding/2),
            
            separatorView.topAnchor.constraint(equalTo: senderImageView.bottomAnchor, constant: ViewConstants.padding)
        ])
    }
    
    private func configureSenderViews(_ senderLabel: UILabel) {
        senderContainerView.makeAutoLayout()
        
        senderLabel.font = .systemFont(ofSize: FontConstants.small)
        senderLabel.makeAutoLayout()
        senderLabel.text = "SENDER"
        senderLabel.textColor = .gray
        
        senderImageView.applyRoundedCorners()
        senderImageView.makeAutoLayout()
        
        senderNameLabel.makeAutoLayout()
    }
    
}

// Addresses and delivery

extension ExpandedCellView {
    
    private func setupInfoViewsContainerView() {
        configureInfoViews()
        
        let separatorView = SeparatorView()
        
        addSubview(infoViewsContainerView)
        infoViewsContainerView.addSubview(addressView)
        infoViewsContainerView.addSubview(separatorView)
        infoViewsContainerView.addSubview(deliveryView)
        
        infoViewsContainerView.constrainByWidth()
        addressView.constrainByWidth(ViewConstants.margin)
        separatorView.constrainByWidth(ViewConstants.margin)
        deliveryView.constrainByWidth(ViewConstants.margin)
        
        NSLayoutConstraint.activate([
            infoViewsContainerView.topAnchor.constraint(equalTo: senderContainerView.bottomAnchor),
            infoViewsContainerView.heightAnchor.constraint(equalToConstant: ViewConstants.profileDimension*1.3),
            
            addressView.topAnchor.constraint(equalTo: infoViewsContainerView.topAnchor),
            separatorView.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: ViewConstants.padding),
            deliveryView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: ViewConstants.padding),
        ])
    }
    
    private func configureInfoViews() {
        infoViewsContainerView.makeAutoLayout()
        addressView.makeAutoLayout()
        deliveryView.makeAutoLayout()
        
        configureInfoView(addressView.leftView, title: "FROM")
        configureInfoView(addressView.rightView, title: "TO")
        configureInfoView(deliveryView.leftView, title: "DELIVERY DATE")
        configureInfoView(deliveryView.rightView, title: "REQUEST DEADLINE")
    }
    
    private func configureInfoView(_ infoView: InfoView, title: String) {
        infoView.topLabel.text = title
        infoView.bottomLabel.font = .systemFont(ofSize: FontConstants.small)
        infoView.bottomLabel.textColor = .black
    }
    
    private func updateDeliveryDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        deliveryView.leftView.bottomLabel.text = dateFormatter.string(from: deliveryDate)
    }
    
    private func updateDeadlineDate() {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.day, .hour, .minute, .second]
        dateFormatter.maximumUnitCount = 1
        dateFormatter.unitsStyle = .full
        
        deliveryView.rightView.bottomLabel.text = dateFormatter.string(from: Date(), to: deadlineDate)
    }
    
}

// Request button

extension ExpandedCellView {
    
    private func setupRequestButtonContainerview() {
        let requestButton = UIButton()
        
        configureRequestsViews(requestButton)
        
        addSubview(requestButtonContainerview)
        requestButtonContainerview.addSubview(requestButton)
        requestButtonContainerview.addSubview(requestsLabel)
        
        requestButtonContainerview.constrainByWidth()
        requestButton.constrainByWidth(ViewConstants.margin)
        
        NSLayoutConstraint.activate([
            requestButtonContainerview.topAnchor.constraint(equalTo: infoViewsContainerView.bottomAnchor),
            requestButtonContainerview.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            requestButton.topAnchor.constraint(equalTo: requestButtonContainerview.topAnchor),
            requestButton.centerXAnchor.constraint(equalTo: requestButtonContainerview.centerXAnchor),
            requestButton.heightAnchor.constraint(equalToConstant: ViewConstants.rowDimension),
            
            requestsLabel.topAnchor.constraint(equalTo: requestButton.bottomAnchor, constant: ViewConstants.padding/2),
            requestsLabel.centerXAnchor.constraint(equalTo: requestButtonContainerview.centerXAnchor),
        ])
    }
    
    private func configureRequestsViews(_ requestButton: UIButton) {
        requestButtonContainerview.makeAutoLayout()
        
        requestButton.applyRoundedCorners()
        requestButton.backgroundColor = ColourConstants.gold
        requestButton.addTarget(self, action: #selector(tappedRequestButton), for: .touchUpInside)
        requestButton.makeAutoLayout()
        requestButton.setTitle("REQUEST", for: .normal)
        requestButton.setTitleColor(.black, for: .normal)
        
        requestsLabel.font = .systemFont(ofSize: 10)
        requestsLabel.makeAutoLayout()
        requestsLabel.textAlignment = .center
        requestsLabel.textColor = .gray
    }
    
    private func updateRequestsLabel() {
        if amountOfRequests == 0 {
            requestsLabel.text = "No requests made"
        } else if amountOfRequests > 0 {
            requestsLabel.text = "\(amountOfRequests) \(amountOfRequests == 1 ? "person has" : "people have") sent a request"
        }
    }
    
    @objc private func tappedRequestButton() {
        print("Requesting!")
    }
    
}
