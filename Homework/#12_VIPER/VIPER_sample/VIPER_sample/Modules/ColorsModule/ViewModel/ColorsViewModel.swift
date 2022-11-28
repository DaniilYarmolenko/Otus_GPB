//
//  ColorsViewModel.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//

import Foundation

final class ColorsViewModel: BaseCellModel {
    typealias ActionHandler = (Int) -> Void
    var action: ActionHandler?

    override var cellIdentifier: String {
        return "ColorsViewModel"
    }
    let array: [ColorModel]

    init(action: ActionHandler? = nil, newColor: [ColorModel]) {
        self.action = action
        self.array = newColor
    }
}
