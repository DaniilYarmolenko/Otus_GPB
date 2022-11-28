//
//  DetailColorCell.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//

import Foundation
import UIKit
class DetailColorCell: UICollectionViewCell {
    static let cellIdentifier = String(describing: DetailColorCell.self)

    var viewColor = UIView()
    
    
    var cartButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    private func setUp() {
//        addConstraint()
        setUpColorView()
//        setUpButtonCart()
    }
    private func setUpColorView(){
        self.clipsToBounds = true
        self.autoresizesSubviews = true
        
        viewColor.frame = self.bounds
        viewColor.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(viewColor)
    }
    private func setUpButtonCart(){
        cartButton.setImage(UIImage(named: "cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        viewColor.addSubview(cartButton)
    }
    private func addConstraint() {
        self.cartButton.translatesAutoresizingMaskIntoConstraints = false
        self.cartButton.centerYAnchor.constraint(equalTo: self.viewColor.centerYAnchor).isActive = true
        self.cartButton.centerXAnchor.constraint(equalTo: self.viewColor.centerXAnchor).isActive = true
        self.cartButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc
    func addToCart(){
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(model: BaseCellModel?, complition: @escaping () -> (Bool)) {
        guard let model = model as? ColorDetailModel else { return }
        self.viewColor.backgroundColor = model.color
    }
    
}
