//
//  CartViewController+Constraints.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//

import Foundation
extension CartViewController {
    func addViewConstraints() {
        self.emptyCartView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyCartView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.emptyCartView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.emptyCartView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.emptyCartView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.goAlertButton.translatesAutoresizingMaskIntoConstraints = false
        self.goAlertButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        self.goAlertButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.goAlertButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.goAlertButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
