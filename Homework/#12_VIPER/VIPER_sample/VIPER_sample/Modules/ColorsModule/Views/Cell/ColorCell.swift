//
//  ColorCell.swift
//  VIPER_Otus
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    static let cellIdentifier = "ColorCell"
    internal var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [label].forEach { [weak self] view  in
            self?.contentView.addSubview(view)
        }
        addConstraints()
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        setUpColorView()
        setUpLabel()
    }
    private func setUpColorView() {
        contentView.layer.cornerRadius = 10
    }
    private func setUpLabel() {
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
    }
    func configure(model: BaseCellModel?, complition: @escaping () -> (Bool)) {
        guard let model = model as? ColorModel else { return }
        self.contentView.backgroundColor = model.color
        label.text = model.name
    }
}
