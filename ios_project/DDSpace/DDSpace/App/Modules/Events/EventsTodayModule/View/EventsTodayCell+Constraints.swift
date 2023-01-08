//
//  EventsTodayCell+Constraints.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 11.12.2022.
//

import Foundation
extension EventsTodayCell {
    internal func addConstraintImageEventView() {
        self.imageEventView.translatesAutoresizingMaskIntoConstraints = false
        self.imageEventView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.imageEventView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.imageEventView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.imageEventView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        self.reverseButton.translatesAutoresizingMaskIntoConstraints = false
        self.reverseButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        self.reverseButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.reverseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.reverseButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    internal func addConstraintsInfoView() {
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        self.infoView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.infoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.infoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        self.reverseButton.translatesAutoresizingMaskIntoConstraints = false
        self.reverseButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        self.reverseButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.reverseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.reverseButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 10).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: self.contentView.bounds.height/4).isActive = true
        self.nameLabel.widthAnchor.constraint(equalToConstant: self.contentView.bounds.width - 40).isActive = true
        
        self.dateEvent.translatesAutoresizingMaskIntoConstraints = false
        self.dateEvent.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        self.dateEvent.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.dateEvent.heightAnchor.constraint(equalTo: self.nameLabel.heightAnchor).isActive = true
        self.dateEvent.widthAnchor.constraint(equalTo: self.nameLabel.widthAnchor).isActive = true
        
        self.registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.registerButton.topAnchor.constraint(equalTo: self.dateEvent.bottomAnchor, constant: 10).isActive = true
        self.registerButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.registerButton.bottomAnchor.constraint(equalTo: self.infoView.bottomAnchor, constant: -10).isActive = true
        self.registerButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
    }
}
