//
//  ColorModel.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//

import Foundation
import UIKit

final class ColorModel: BaseCellModel {
    let color: UIColor
    let name: String
    let colorType: Color
    init(red: CGFloat, green: CGFloat, blue: CGFloat, colorType: Color) {
        self.color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        self.colorType = colorType
        self.name = colorType.rawValue
    }
    override var cellIdentifier: String {
        return "ColorCell"
    }
}
