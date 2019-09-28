//
//  ExpandedInfoView.swift
//  CollapsableCell
//
//  Created by Mohamed Marbouh on 2019-09-27.
//  Copyright © 2019 Mohamed Marbouh. All rights reserved.
//

import UIKit

class ExpandedInfoView: UIView {

    let leftView = InfoView()
    let rightView = InfoView()
    
    private let stackView = UIStackView()
    
    init() {
        super.init(frame: .zero)
        
        stackView.axis = .horizontal
        stackView.makeAutoLayout()
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(rightView)
        
        stackView.constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
