//
//  SigninViewController+Contraints.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 04.01.2023.
//

import Foundation
extension SigninViewController {
    internal func addConstraint() {
        self.ddImageView.translatesAutoresizingMaskIntoConstraints = false
        self.ddImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        self.ddImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.ddImageView.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/1.5).isActive = true
        self.ddImageView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/3).isActive = true
        
        self.loginTF.translatesAutoresizingMaskIntoConstraints = false
        self.loginTF.topAnchor.constraint(equalTo: self.ddImageView.bottomAnchor, constant: 10).isActive = true
        self.loginTF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loginTF.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/1.5).isActive = true
        self.loginTF.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.password.translatesAutoresizingMaskIntoConstraints = false
        self.password.topAnchor.constraint(equalTo: self.loginTF.bottomAnchor, constant: 10).isActive = true
        self.password.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.password.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/1.5).isActive = true
        self.password.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.labelError.translatesAutoresizingMaskIntoConstraints = false
        self.labelError.topAnchor.constraint(equalTo: self.password.bottomAnchor, constant: 10).isActive = true
        self.labelError.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.labelError.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/1.5).isActive = true
        self.labelError.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.topAnchor.constraint(equalTo: self.password.bottomAnchor, constant: 50).isActive = true
        self.loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loginButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/1.5).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.guessButton.translatesAutoresizingMaskIntoConstraints = false
        self.guessButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 10).isActive = true
        self.guessButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.guessButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/1.5).isActive = true
        self.guessButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.signUpButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.signUpButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/1.5).isActive = true
        self.signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
