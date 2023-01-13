//
//  CustomLabel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import UIKit

final class CustomLabel: UILabel {
    var insets = UIEdgeInsets.zero
    var top = false
    
    func padding(_ top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width + left + right, height: self.frame.height + top + bottom)
        insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    override func drawText(in rect: CGRect) {
        var textRect = rect
        if top == true {
            textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        }
        super.drawText(in: textRect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += insets.top + insets.bottom
        contentSize.width += insets.left + insets.right
        return contentSize
    }
}
