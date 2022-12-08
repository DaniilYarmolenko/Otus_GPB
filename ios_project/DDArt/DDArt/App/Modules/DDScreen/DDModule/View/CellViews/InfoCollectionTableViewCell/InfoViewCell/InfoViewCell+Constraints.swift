//
//  InfoViewCell+Constraints.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation

extension InfoViewCell {
     func addConstraints() {
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
         self.mapView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
         self.mapView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
         self.mapView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
         self.mapView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/2.8).isActive = true
         
         self.addressButton.translatesAutoresizingMaskIntoConstraints = false
         self.addressButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
         self.addressButton.bottomAnchor.constraint(equalTo: self.mapView.topAnchor, constant: -16).isActive = true
         self.addressButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/3*2 - 10).isActive = true
         
         self.socialButtonHStack.translatesAutoresizingMaskIntoConstraints = false
         self.socialButtonHStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
         self.socialButtonHStack.bottomAnchor.constraint(equalTo: self.addressButton.bottomAnchor).isActive = true
         self.socialButtonHStack.topAnchor.constraint(equalTo: self.addressButton.topAnchor).isActive = true
         self.socialButtonHStack.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/3 - 10).isActive = true
         
         self.phoneButton.translatesAutoresizingMaskIntoConstraints = false
         self.phoneButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
         self.phoneButton.bottomAnchor.constraint(equalTo: self.addressButton.topAnchor, constant: -16).isActive = true
         self.phoneButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
         self.phoneButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2 - 10).isActive = true
         
         self.emailButton.translatesAutoresizingMaskIntoConstraints = false
         self.emailButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24).isActive = true
         self.emailButton.bottomAnchor.constraint(equalTo: self.phoneButton.bottomAnchor).isActive = true
         self.emailButton.topAnchor.constraint(equalTo: self.phoneButton.topAnchor).isActive = true
         self.emailButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2 - 10).isActive = true
    }
}
