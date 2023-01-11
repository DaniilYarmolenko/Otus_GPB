//
//  ColorCell+Constraints.swift
//  VIPER_Otus
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//

import Foundation
extension ColorCell {
    internal func addConstraints() {

        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.label.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
