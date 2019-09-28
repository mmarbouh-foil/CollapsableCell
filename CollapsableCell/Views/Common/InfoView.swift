//
//  InfoView.swift
//  CollapsableCell
//
//  Created by Mohamed Marbouh on 2019-09-27.
//  Copyright © 2019 Mohamed Marbouh. All rights reserved.
//

import UIKit

class InfoView: UIView {

    let topLabel = UILabel()
    let bottomLabel = UILabel()
    
    private let stackView = UIStackView()
    
    init() {
        super.init(frame: .zero)
        
        configureViews()
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(topLabel)
        stackView.addArrangedSubview(bottomLabel)
        
        stackView.constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextColour(_ colour: UIColor) {
        topLabel.textColor = colour
        bottomLabel.textColor = colour
    }
    
    private func configureViews() {
        configureLabel(topLabel)
        configureLabel(bottomLabel)
        
        topLabel.font = .systemFont(ofSize: 12)
        bottomLabel.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .semibold)
        
        stackView.axis = .vertical
        stackView.makeAutoLayout()
    }
    
    private func configureLabel(_ label: UILabel) {
        label.makeAutoLayout()
        label.textColor = .gray
    }

}
