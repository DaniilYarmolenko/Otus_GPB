//
//  UIImageView+Extension.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 02.12.2022.
//

import UIKit
extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image, contentMode == .scaleAspectFit else { return bounds }
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        guard imageWidth > 0 && imageHeight > 0 else { return bounds }

        let scale: CGFloat
        if imageWidth > imageHeight {
            scale = bounds.size.width / imageWidth
        } else {
            scale = bounds.size.height / imageHeight
        }
        let clippingSize = CGSize(width: imageWidth * scale, height: imageHeight * scale)
        let x = (bounds.size.width - clippingSize.width) / 2.0
        let y = (bounds.size.height - clippingSize.height) / 2.0
        return CGRect(origin: CGPoint(x: x, y: y), size: clippingSize)
    }
}
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
