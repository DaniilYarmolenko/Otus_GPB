//
//  ColorDetailViewModel.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//

final class ColorDetailViewModel: BaseCellModel {
    typealias ActionHandler = (Int) -> Void
    var action: ActionHandler?

    override var cellIdentifier: String {
        return "ColorDetailViewModel"
    }
    let array: [ColorDetailModel]

    init(action: ActionHandler? = nil, newColor: [ColorDetailModel]) {
        self.action = action
        self.array = newColor
    }
}
