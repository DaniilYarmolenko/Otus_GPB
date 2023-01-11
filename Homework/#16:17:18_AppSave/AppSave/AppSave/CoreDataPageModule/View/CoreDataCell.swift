//
//  CoreDataCell.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 03.12.2022.
//

import UIKit
class CoreDataCell: BaseDataCell {
    private var nameLabel = UILabel()
    private var urlLabel = UILabel()
    internal var imageV = UIImageView()
    internal var trash = UIButton()
    internal var delegate: CoreDataPageViewOutput?
    internal var HStackIn = UIStackView()
    static let cellIdentifier = "CoreDataCell"
    
    override func updateViews() {
        guard let model = model as? ImageSaveModel else { return }
        nameLabel.text = model.name
        urlLabel.text = model.url
        imageV.image = UIImage(data: model.data)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        setUpBase()
        setUpLabel(label: nameLabel, weight: .heavy, numberOfLines: 0)
        setUpLabel(label: urlLabel, numberOfLines: 0)
        setUpView(view: imageV)
        trash.setImage(UIImage(named: "trash"), for: .normal)
        trash.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
        setUpStack()
        
    }
    @objc
    private func actionDelete() {
        guard let model = model as? ImageSaveModel else { return }
        delegate?.delete(name: model.name)
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
                views: imageV, CreateStack.createStack(
                            distribution: .equalCentering,
                            alignmentStack: .leading,
                            views: nameLabel, urlLabel)
            )
        )
    }
    func addViewConstraints() {
       HStackIn.translatesAutoresizingMaskIntoConstraints = false
       HStackIn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
       HStackIn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
       HStackIn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
       HStackIn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
       
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageV.heightAnchor.constraint(equalTo: imageV.widthAnchor).isActive = true
       
       trash.translatesAutoresizingMaskIntoConstraints = false
       trash.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
       trash.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
   }
}
