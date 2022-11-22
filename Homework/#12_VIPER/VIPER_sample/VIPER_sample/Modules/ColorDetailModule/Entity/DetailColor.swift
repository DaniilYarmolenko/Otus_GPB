//
//  DetailColor.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//
import UIKit
final class ColorDetailModel: BaseCellModel {
    let color: UIColor
    let id: Int
    let red: Float
    let green: Float
    let blue: Float
    var inCart: Bool
    init(red: CGFloat, green: CGFloat, blue: CGFloat, inCart:  Bool = false) {
        self.color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        self.inCart =  inCart
        self.id = Int(red*100+green*1000+blue*10000)
        self.red = Float(red)
        self.green = Float(green)
        self.blue = Float(blue)

    }
    override var cellIdentifier: String {
        return "DetailColorCell"
    }
}
