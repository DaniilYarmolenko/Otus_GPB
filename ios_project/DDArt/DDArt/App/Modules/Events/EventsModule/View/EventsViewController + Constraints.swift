//
//  EventsViewControllerConstraints.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 03.11.2022.
//

import UIKit

extension EventsViewController {
    func addViewConstraints() {
        eventPageVC.view.translatesAutoresizingMaskIntoConstraints = false
        interfaceSegmented.translatesAutoresizingMaskIntoConstraints = false
        
        interfaceSegmented.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        interfaceSegmented.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        interfaceSegmented.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        interfaceSegmented.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        eventPageVC.view.topAnchor.constraint(equalTo: interfaceSegmented.bottomAnchor, constant: 10).isActive = true
        eventPageVC.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        eventPageVC.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        eventPageVC.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
