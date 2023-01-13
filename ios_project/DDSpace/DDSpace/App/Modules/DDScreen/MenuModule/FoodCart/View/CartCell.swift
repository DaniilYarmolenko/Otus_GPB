//
//  CartCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.01.2023.
//

import UIKit
class CartCell: UITableViewCell{
    private var nameLabel = UILabel()
    internal var imageV = UIImageView()
    internal var costCountLabel = UILabel()
    internal var stepper = UIStepper()
    weak var delegate: FoodCartViewOutput?
    var model: FoodSaveModel?
    var cost: Int = 0
    static let cellIdentifier = "CartCell"
    
    func configure(model: FoodSaveModel) {
        nameLabel.text = model.nameFood
        imageV.image = UIImage(data: model.data)
        stepper.value = Double(model.count)
        cost = model.cost
        self.model = model
        costCountLabel.attributedText = "\(cost)₽ X \(model.count)".underLined
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        [imageV, nameLabel, costCountLabel, stepper].forEach {contentView.addSubview($0)}
        addViewConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        setUpLabels()
        setUpImageView()
        setUpStepper()
    }
    private func setUpStepper() {
        stepper.minimumValue = 0
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
    }
    private func setUpLabels() {
        nameLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 30)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        costCountLabel.font = UIFont(name: FontConstants.MoniqaLightItalicHeading, size: 24)
        costCountLabel.textColor = .black
    }
    private func setUpImageView() {
        imageV.contentMode = .scaleToFill
        imageV.layer.cornerRadius = 10
    }
    @objc
    func stepperChanged() {
        if stepper.value == 0 {
            if let model = model {
                delegate?.delete(id: model.id)
            }
        } else {
            if let model = model {
                let newModel = FoodSaveModel(id: model.id, nameFood: model.nameFood, data: model.data, count: Int(stepper.value), cost: model.cost)
                delegate?.updateCount(food: newModel)
            }
            
        }
        
    }
    func addViewConstraints() {
        
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant:  -10).isActive = true
        imageV.widthAnchor.constraint(equalTo: imageV.heightAnchor).isActive = true
        imageV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        imageV.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: imageV.trailingAnchor, constant: 3).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageV.topAnchor, constant: 40).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/3).isActive = true
        
        costCountLabel.translatesAutoresizingMaskIntoConstraints = false
        costCountLabel.leadingAnchor.constraint(equalTo: imageV.trailingAnchor).isActive = true
        costCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        costCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        costCountLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5).isActive = true
        stepper.bottomAnchor.constraint(equalTo: costCountLabel.bottomAnchor).isActive = true
        stepper.trailingAnchor
            .constraint(equalTo: contentView.trailingAnchor).isActive = true
        stepper.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    }
}
