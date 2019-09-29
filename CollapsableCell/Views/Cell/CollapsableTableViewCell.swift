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
            collapsedView.isHidden = true
            expandedView.isHidden = false
        } else {
            collapsedView.isHidden = false
            expandedView.isHidden = true
        }
    }
    
    func isExpanded() -> Bool {
        return collapsedView.isHidden
    }
    
    // NOTE: folding animation is still janky. Uncomment to see what it looks like.
    
    func expand() {
//        apply(folding: .expand) {
            self.collapsedView.isHidden = true
            self.expandedView.isHidden = false
//        }
    }
    
    func collapse() {
//        apply(folding: .collapse) {
            self.collapsedView.isHidden = false
            self.expandedView.isHidden = true
//        }
    }
    
}

// Folding animation
// Taken from: https://github.com/rbobbins/animation-demo/

enum FoldingOperation {
    case collapse, expand
}

extension CollapsableTableViewCell {
    
    private func apply(folding operation: FoldingOperation, completion: @escaping () -> Void) {
        guard let splits = splits() else { return }
        guard let top = splits.first, let bottom = splits.last else { return }
        
        let animationContainer = UIView(frame: bounds)
        let originalbackgroundColour = backgroundColor
        
        animationContainer.backgroundColor = .clear
        backgroundColor = .clear
        contentView.subviews.forEach { $0.isHidden = true }
        
        addSubview(animationContainer)
        animationContainer.addSubview(top)
        animationContainer.addSubview(bottom)
        
        var originTransform = CATransform3DIdentity
        originTransform.m34 = -1 / 500
        
        let originFrame = CGRect(x: 0, y: -top.frame.height / 2, width: top.frame.width, height: top.frame.height)
        top.frame = originFrame
        bottom.frame = originFrame
        
        top.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        bottom.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        top.layer.transform = originTransform
        bottom.layer.transform = originTransform
        
        let topShadow = CAGradientLayer()
        topShadow.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        topShadow.frame = top.bounds
        top.layer.addSublayer(topShadow)
        
        let bottomShadow = CAGradientLayer()
        bottomShadow.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        bottomShadow.frame = bottom.bounds
        bottom.layer.addSublayer(bottomShadow)
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
            self.backgroundColor = originalbackgroundColour
            self.contentView.subviews.forEach { $0.isHidden = false }
            
            animationContainer.removeFromSuperview()
            completion()
        }
        
        let topRotation = CABasicAnimation(keyPath: "transform.rotation.x")
        topRotation.fillMode = .forwards
        topRotation.isRemovedOnCompletion = false
        
        switch operation {
            case .expand:
                topRotation.fromValue = -(Double.pi / 2)
                topRotation.toValue = 0
                break
            case .collapse:
                topRotation.fromValue = 0
                topRotation.toValue = -(Double.pi / 2)
        }
        
        top.layer.add(topRotation, forKey: nil)
        
        let bottomRotation = CABasicAnimation(keyPath: "transform.rotation.x")
        bottomRotation.fillMode = .forwards
        bottomRotation.isRemovedOnCompletion = false
        
        switch operation {
            case .expand:
                bottomRotation.fromValue = Double.pi / 2
                bottomRotation.toValue = 0
                break
            case .collapse:
                bottomRotation.fromValue = 0
                bottomRotation.toValue = Double.pi
        }
        
        bottom.layer.add(bottomRotation, forKey: nil)
        
        let bottomTranslation = CABasicAnimation(keyPath: "transform.translation.y")
        bottomTranslation.fillMode = .forwards
        bottomTranslation.isRemovedOnCompletion = false
        
        switch operation {
            case .expand:
                bottomTranslation.fromValue = top.frame.minY
                bottomTranslation.toValue = 2 * bottom.frame.height
                bottomTranslation.timingFunction = CAMediaTimingFunction(name: .easeOut)
                break
            case .collapse:
                bottomTranslation.fromValue = 2 * bottom.frame.height
                bottomTranslation.toValue = top.frame.minY
                bottomTranslation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        }
        
        bottom.layer.add(bottomTranslation, forKey: nil)
        
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fillMode = .forwards
        opacity.isRemovedOnCompletion = false
        
        switch operation {
            case .expand:
                opacity.fromValue = 1
                opacity.toValue = 0
                break
            case .collapse:
                opacity.fromValue = 0
                opacity.toValue = 1
        }
        
        topShadow.add(opacity, forKey: nil)
        bottomShadow.add(opacity, forKey: nil)
        
        CATransaction.commit()
    }
    
    private func splits() -> [UIImageView]? {
        var results: [UIImageView] = []
        
        let topFrame = CGRect(x: 0, y: 0, width: frame.width, height: floor(frame.height / 2))
        let bottomFrame = CGRect(x: 0, y: topFrame.maxY, width: frame.width, height: ceil(frame.height / 2))
        
        UIGraphicsBeginImageContext(frame.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        layer.render(in: context)
        
        let fullImageView = UIGraphicsGetImageFromCurrentImageContext()
        
        guard let topImageRef = fullImageView?.cgImage?.cropping(to: topFrame) else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        guard let bottomImageRef = fullImageView?.cgImage?.cropping(to: bottomFrame) else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        let topView = UIImageView()
        topView.image = UIImage(cgImage: topImageRef)
        topView.frame = topFrame
        
        let bottomView = UIImageView()
        bottomView.image = UIImage(cgImage: bottomImageRef)
        bottomView.frame = bottomFrame
        
        results.append(contentsOf: [topView, bottomView])
        
        return results
    }
    
}
