//
//  Utilities.swift
//  VIPER_Sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
// REFERENCE Stackoverflow

import UIKit

extension CGRect {
    func dividedIntegral(fraction: CGFloat, from fromEdge: CGRectEdge) -> (first: CGRect, second: CGRect) {
        let dimension: CGFloat
        
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            dimension = self.size.width
        case .minYEdge, .maxYEdge:
            dimension = self.size.height
        }
        
        let distance = (dimension * fraction).rounded(.up)
        var slices = self.divided(atDistance: distance, from: fromEdge)
        
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            slices.remainder.origin.x += 1
            slices.remainder.size.width -= 1
        case .minYEdge, .maxYEdge:
            slices.remainder.origin.y += 1
            slices.remainder.size.height -= 1
        }
        
        return (first: slices.slice, second: slices.remainder)
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
final class CreateStack {
   static func createStack(axis: NSLayoutConstraint.Axis = .vertical,
                           distribution: UIStackView.Distribution = .fillEqually,
                           alignmentStack: UIStackView.Alignment,
                           spacing: CGFloat = 5,
                           views: UIView...) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.distribution = distribution
        stack.alignment = alignmentStack
        stack.spacing = spacing
        views.forEach { view in
            stack.addArrangedSubview(view)
        }
        return stack
    }
}
