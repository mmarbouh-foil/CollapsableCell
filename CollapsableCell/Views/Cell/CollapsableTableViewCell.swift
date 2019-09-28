//
//  CollapsableTableViewCell.swift
//  CollapsableCell
//
//  Created by Mohamed Marbouh on 2019-09-27.
//  Copyright © 2019 Mohamed Marbouh. All rights reserved.
//

import UIKit

class CollapsableTableViewCell: UITableViewCell {
    
    private let collapsedView = CollapsedPreviewView()
    private let expandedView = ExpandedCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        collapsedView.makeAutoLayout()
        expandedView.makeAutoLayout()
        
        expandedView.isHidden = true
        
        contentView.addSubview(collapsedView)
        contentView.addSubview(expandedView)
        
        collapsedView.constrain(to: nil, constant: ViewConstants.margin)
        expandedView.constrain(to: nil, constant: ViewConstants.margin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with card: Card, expanded: Bool) {
        collapsedView.configure(with: card)
        expandedView.configure(with: card)
        
        if expanded {
            expand()
        } else {
            collapse()
        }
    }
    
    func isExpanded() -> Bool {
        return collapsedView.isHidden
    }
    
    func expand() {
        collapsedView.isHidden = true
        expandedView.isHidden = false
    }
    
    func collapse() {
        collapsedView.isHidden = false
        expandedView.isHidden = true
    }
    
}
