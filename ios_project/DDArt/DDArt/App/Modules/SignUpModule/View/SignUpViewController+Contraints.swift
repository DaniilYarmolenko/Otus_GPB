//
//  SignUpViewController+Contraints.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.01.2023.
//

import Foundation
import UIKit
extension SignUpViewController {
    internal func addContraints() {
        NSLayoutConstraint.activate([
            
            dismissButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            dismissButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            dismissButton.widthAnchor.constraint(equalToConstant: 40),
            dismissButton.heightAnchor.constraint(equalToConstant: 40),
            
            scroll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            scroll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            scroll.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 30),
            scroll.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10),
            
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            
            signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20),
            signUpButton.widthAnchor.constraint(equalToConstant: 150),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
