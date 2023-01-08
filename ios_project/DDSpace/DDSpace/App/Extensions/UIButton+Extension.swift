//
//  UIButton+Extension.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 02.12.2022.
//

import UIKit

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
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
