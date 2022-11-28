//
//  CartTableViewCell.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//


import UIKit
class CartTableViewCell: BaseCartCell {
    private var red = UILabel()
    private var blue = UILabel()
    private var green = UILabel()
    internal var colorView = UIView()
    internal var trash = UIButton()
    internal var delegate: CartViewOutput?
    internal var HStackIn = UIStackView()
    static let cellIdentifier = "CartViewCell"
    
    override func updateViews() {
        guard let model = model as? ColorDetailModel else { return }
        red.text = "\(model.red)"
        blue.text = "\(model.blue)"
        green.text = "\(model.green)"
        self.colorView.backgroundColor = model.color
        trash.isHidden = false
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [HStackIn, trash].forEach({
            contentView.addSubview($0)
        })
        
        addViewConstraints()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        setUpBase()
        setUpLabel(label: red, weight: .heavy, numberOfLines: 0)
        setUpLabel(label: green, numberOfLines: 0)
        setUpLabel(label: blue, numberOfLines: 0)
        setUpColorView(view: colorView)
        trash.setImage(UIImage(named: "trash"), for: .normal)
        trash.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
        setUpStack()
    }
    @objc
    private func actionDelete() {
        guard let model = model as? ColorDetailModel else { return }
        delegate?.delete(id: model.id)
    }
    
    private func setUpStack() {
        HStackIn.axis  = .horizontal
        HStackIn.distribution  = .fillProportionally
        HStackIn.alignment = .center
        HStackIn.addArrangedSubview(
            CreateStack.createStack(
                axis: .horizontal,
                distribution: .fill,
                alignmentStack: .center,
                spacing: 10,
                views: colorView, CreateStack.createStack(
                            distribution: .equalCentering,
                            alignmentStack: .leading,
                            views: red, green, red)
            )
        )
    }
    func addViewConstraints() {
       HStackIn.translatesAutoresizingMaskIntoConstraints = false
       HStackIn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
       HStackIn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
       HStackIn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
       HStackIn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
       
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        colorView.heightAnchor.constraint(equalTo: colorView.widthAnchor).isActive = true
       
       trash.translatesAutoresizingMaskIntoConstraints = false
       trash.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
       trash.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
   }
}
