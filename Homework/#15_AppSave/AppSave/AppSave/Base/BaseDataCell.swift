//
//  BaseDataCell.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 03.12.2022.
//

import UIKit

class BaseDataCell: BaseCell {
    
    func setUpBase() {
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        selectionStyle = .none
    }
    
    func setUpView(view: UIView) {
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 100
    }
    
    func setUpLabel(label: UILabel, fontSize: CGFloat = 14, weight: UIFont.Weight = .regular, numberOfLines: Int = 1) {
        label.numberOfLines = numberOfLines
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
}
