//
//  BaseCartCell.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//

import UIKit

class BaseCartCell: BaseCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpBase() {
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        selectionStyle = .none
    }
    
    func setUpColorView(view: UIView) {
        view.layer.cornerRadius = 10
    }
    
    func setUpLabel(label: UILabel, fontSize: CGFloat = 14, weight: UIFont.Weight = .regular, numberOfLines: Int = 1) {
        label.numberOfLines = numberOfLines
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
}
