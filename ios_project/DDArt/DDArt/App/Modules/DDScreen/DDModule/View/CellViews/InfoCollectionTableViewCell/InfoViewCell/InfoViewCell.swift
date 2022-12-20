//
//  InfoViewCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation
import UIKit
import MapKit
final class InfoViewCell: BaseCell {
    static let cellIdentifier = String(describing: InfoViewCell.self)

    internal var mapView = MKMapView()
    internal var addressButton = ButtonWithLabel()
    internal var phoneButton = ButtonWithLabel()
    internal var emailButton = ButtonWithLabel()
    internal var socialButtonHStack = UIStackView()
    internal var vkButton = UIButton()
    internal var instagramButton = UIButton()
    internal var telegramButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [mapView, addressButton, phoneButton, emailButton, socialButtonHStack, phoneButton].forEach { [weak self] view in
            self?.contentView.addSubview(view)
        }
        contentView.backgroundColor = .clear
        setUp()
        addConstraints()
        
    }
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpButtons()
        setUpLabels()
        setUpMap()
        setUpSocialHStack()
    }

    private func setUpButtons() {
        phoneButton.setImage(UIImage(named: ImageNameConstants.phone), for: .normal)
        phoneButton.addTarget(self, action: #selector(phoneButtonAction), for: .touchUpInside)
        emailButton.setImage(UIImage(named: ImageNameConstants.email), for: .normal)
        emailButton.addTarget(self, action: #selector(emailButtonAction), for: .touchUpInside)
        emailButton.setTitle(LabelConstants.EmailButtonLabel, for: .normal)
        addressButton.setImage(UIImage(named: ImageNameConstants.marker), for: .normal)
        vkButton.setImage(UIImage(named: ImageNameConstants.vk), for: .normal)
        instagramButton.setImage(UIImage(named: ImageNameConstants.instagram), for: .normal)
        telegramButton.setImage(UIImage(named: ImageNameConstants.telegram), for: .normal)
        addressButton.addTarget(self, action: #selector(addressButtonAction), for: .touchUpInside)
        vkButton.addTarget(self, action: #selector(vkButtonAction), for: .touchUpInside)
        telegramButton.addTarget(self, action: #selector(telegramButtonAction), for: .touchUpInside)
        instagramButton.addTarget(self, action: #selector(instagramButtonAction), for: .touchUpInside)

    }
    
    override func updateViews() {
        guard let model = model as? InfoCollectionViewModel else { return }
        guard !model.infoModel.isEmpty else {return}
        addressButton.setTitle(model.infoModel[0].address, for: .normal)
        phoneButton.setTitle(model.infoModel[0].phoneNumber, for: .normal)
        print(model.infoModel[0])
    }
    private func setUpSocialHStack() {
        socialButtonHStack.axis  = .horizontal
        socialButtonHStack.addArrangedSubview(
            CreateStack.createStack(
                axis: .horizontal,
                distribution: .fillEqually,
                alignmentStack: .center,
                spacing: 0,
                views: vkButton, instagramButton, telegramButton)
        )
    }

    private func setUpLabels() {
        emailButton.setTitleColor(.black, for: .normal)
        emailButton.contentHorizontalAlignment = .trailing
        phoneButton.setTitleColor(.black, for: .normal)
        phoneButton.contentHorizontalAlignment = .leading
        addressButton.setTitleColor(.black, for: .normal)
        addressButton.contentHorizontalAlignment = .leading
    }
    private func setUpMap() {
        
    }
    @objc
    private func vkButtonAction() {
//        model.output.tapOnVk()
    }
    @objc
    private func telegramButtonAction() {
        print("1")
        print("2")
        guard let model = model as? InfoCollectionViewModel, !model.infoModel.isEmpty else { return }
        print("\(model.infoModel) 1")
        model.output.tapOnTelegram()
    }
    @objc
    private func instagramButtonAction() {
        guard let model = model as? InfoCollectionViewModel, !model.infoModel.isEmpty else { return }
        model.output.tapOnInstagram()
        print("INST 1")
    }
    @objc
    private func phoneButtonAction() {
//        output?.tapOnPhone()
        print("PHONE 1")
    }
    @objc
    private func addressButtonAction() {
//        output?.tapOnMap()
    }
    @objc
    private func emailButtonAction() {
//        output?.tapOnEmail()
    }
}
