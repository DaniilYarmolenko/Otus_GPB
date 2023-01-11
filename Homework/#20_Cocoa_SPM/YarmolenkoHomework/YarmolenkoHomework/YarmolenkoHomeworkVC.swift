//
//  YarmolenkoHomeworkVC.swift
//  YarmolenkoHomework
//
//  Created by Даниил Ярмоленко on 30.11.2022.
//

import Foundation
import UIKit

public class YarmolenkoHomeworkVC: UIViewController {
    internal var label = UILabel()
    override public func viewDidLoad() {
        view.backgroundColor = .purple
        setUpLabel()
    }
    func setUpLabel() {
        view.addSubview(label)
        label.text = "Yarmolenko"
        label.font = .systemFont(ofSize: 64)
        label.textColor = .white
    }
    override public func viewDidLayoutSubviews() {
        addConstraints()
        animateLabels()
    }
    func animateLabels() {
              UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse], animations: {
                   self.label.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
              })
         }
    func addConstraints() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.label.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
