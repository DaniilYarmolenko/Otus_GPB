//
//  UserDefaultsPageViewController+Constraints.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 03.12.2022.
//

import Foundation
extension UserDefaultsPageViewController {
    func addViewConstraints() {
        self.emptyCacheView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyCacheView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 20).isActive = true
        self.emptyCacheView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.emptyCacheView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.emptyCacheView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.searchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.searchBar.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.searchBar.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 10).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.deleteAllButton.translatesAutoresizingMaskIntoConstraints = false
        self.deleteAllButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        self.deleteAllButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.deleteAllButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.deleteAllButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
