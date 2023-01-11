//
//  EmptyCartView.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//

import UIKit

final class EmptyCartView: UIView {
    internal var title = UILabel()
    internal var subTitle = UILabel()
    internal var imageView = UIImageView()
    
    init(frame: CGRect = CGRect.zero, titleText: String = "Ваша корзина пуста", subtitleText: String = "Добавьте цвета") {
        super.init(frame: frame)
        [title, subTitle, imageView].forEach { [weak self] view in
            self?.addSubview(view)
        }
        setUp(titleText: titleText, subtitleText: subtitleText)
        addViewConstraints()
    }
    
    func setUp(titleText: String, subtitleText: String) {
        setLabel(label: subTitle, text: subtitleText, alpha: 0.4, fontSize: 18, weight: .regular)
        setLabel(label: title, text: titleText, alpha: 0.5, fontSize: 36, weight: .bold)
        setUpImageView()
    }
    
    func setLabel(label: UILabel, text: String, alpha: CGFloat, fontSize: CGFloat, weight: UIFont.Weight) {
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = .black
    }
    
    func setUpImageView() {
        imageView.image = UIImage(named: "cartImage")
        imageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension EmptyCartView {
    func addViewConstraints() {
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.subTitle.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 120).isActive = true
        self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.title.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.subTitle.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 10).isActive = true
        self.subTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.subTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 120).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}
