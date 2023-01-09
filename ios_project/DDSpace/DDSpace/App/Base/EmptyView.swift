//
//  EmptyView.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 11.12.2022.
//

import Foundation
import UIKit

final class EmptyView: UIView {
    internal var title = UILabel()
    internal var subTitle = UILabel()
    internal var imageView = UIImageView()
    
    init(frame: CGRect = CGRect.zero, titleText: String = "Сегодня нет событий", subtitleText: String = "Но скоро будут", imageString: String = "cartImage") {
        super.init(frame: frame)
        [title, subTitle, imageView].forEach { [weak self] view in
            self?.addSubview(view)
        }
        setUp(titleText: titleText, subtitleText: subtitleText, imageString: imageString)
        addViewConstraints()
    }
    
    func setUp(titleText: String, subtitleText: String, imageString: String) {
        setLabel(label: subTitle, text: subtitleText, alpha: 0.4, fontSize: 18, weight: .regular)
        setLabel(label: title, text: titleText, alpha: 0.5, fontSize: 36, weight: .bold)
        setUpImageView(imageString: imageString)
    }
    
    func setLabel(label: UILabel, text: String, alpha: CGFloat, fontSize: CGFloat, weight: UIFont.Weight) {
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = .black
    }
    
    func setUpImageView(imageString: String) {
        imageView.image = UIImage(named: imageString)
        imageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension EmptyView {
    func addViewConstraints() {
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.subTitle.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 120).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100).isActive = true
        self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.title.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.subTitle.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 10).isActive = true
        self.subTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.subTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}
