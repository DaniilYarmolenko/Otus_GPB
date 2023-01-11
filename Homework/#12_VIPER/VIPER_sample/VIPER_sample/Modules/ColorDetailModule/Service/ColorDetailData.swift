//
//  ColorDetailData.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//

import Foundation
class ColorDetailData {
    let color: Color
    func sampleDataColor() -> [ColorDetailModel] {
        return makeArrayColors(color: color)
    }
    init(color: Color){
        self.color = color
    }
    func makeArrayColors(color: Color) -> [ColorDetailModel] {
        var array = [ColorDetailModel]()
        switch color {
        case .red:
            for i in 1...255/5 {
                array.append(ColorDetailModel(red: 1.0, green: CGFloat(0+i*5)/255, blue:  CGFloat(0+i*5)/255))
            }
        case .green:
            for i in 1...255/5 {
                array.append(ColorDetailModel(red: CGFloat(0+i*5)/255, green: 1.0, blue:  CGFloat(0+i*5)/255))
            }
        case .blue:
            for i in 1...255 {
                array.append(ColorDetailModel(red: CGFloat(0+i*5)/255, green: CGFloat(0+i*5)/255, blue:  1.0))
            }
        }
        return array
    }
}
enum Color: String {
    case red = "red"
    case green = "green"
    case blue = "blue"
}
