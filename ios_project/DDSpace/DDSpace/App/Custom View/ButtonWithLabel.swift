//
//  ButtonWithLabel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation
import UIKit

final class ButtonWithLabel: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
//            imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: titleLabel!.bounds.width)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        }
    }
}
