//
//  BuyColorVC + Constaints.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//

import Foundation
extension BuyColorViewController {
    internal func addConstraints() {
        self.buyButton.translatesAutoresizingMaskIntoConstraints = false
        self.buyButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.buyButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.buyButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.buyButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
