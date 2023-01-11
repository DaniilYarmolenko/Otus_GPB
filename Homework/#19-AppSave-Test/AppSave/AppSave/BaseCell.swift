//
//  BaseCell.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//

import UIKit

class BaseCell: UITableViewCell, ModelRepresentable {
    var model: BaseCellModel? {
        didSet {
            updateViews()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateViews() { fatalError("USE!!! Abstractions") }
}
