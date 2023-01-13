//
//  BaseCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.12.2022.
//

import UIKit
class BaseCell: UITableViewCell  {
    var model: CellIdentifiable? {
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
