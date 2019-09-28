//
//  SeparatorView.swift
//  CollapsableCell
//
//  Created by Mohamed Marbouh on 2019-09-27.
//  Copyright © 2019 Mohamed Marbouh. All rights reserved.
//

import UIKit

class SeparatorView: UIView {

    init() {
        super.init(frame: .zero)
        
        makeAutoLayout()
        
        backgroundColor = .lightGray
        
        heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
