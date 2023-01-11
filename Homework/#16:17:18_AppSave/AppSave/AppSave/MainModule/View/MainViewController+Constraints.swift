//
//  MainViewController+Constraints.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 02.12.2022.
//

import UIKit

extension MainViewController {
    internal func addConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.bounds.height/2.5).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        line.translatesAutoresizingMaskIntoConstraints = false
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40).isActive = true
        line.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 1).isActive = true
        line.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        labelError.translatesAutoresizingMaskIntoConstraints = false
        labelError.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40).isActive = true
        labelError.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        labelError.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5).isActive = true
        
        cacheButton.translatesAutoresizingMaskIntoConstraints = false
        cacheButton.widthAnchor.constraint(equalToConstant: 200 ).isActive = true
        cacheButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cacheButton.topAnchor.constraint(equalTo: labelError.bottomAnchor, constant: 20).isActive = true
        cacheButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        coreDataButton.translatesAutoresizingMaskIntoConstraints = false
        coreDataButton.widthAnchor.constraint(equalToConstant: 200 ).isActive = true
        coreDataButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        coreDataButton.topAnchor.constraint(equalTo: cacheButton.bottomAnchor, constant: 20).isActive = true
        coreDataButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.widthAnchor.constraint(equalToConstant: 200 ).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: coreDataButton.bottomAnchor, constant: 20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
