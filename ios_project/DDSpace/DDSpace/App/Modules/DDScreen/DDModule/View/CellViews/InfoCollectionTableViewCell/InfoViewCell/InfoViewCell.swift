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
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double(model.infoModel[0].latitude) ?? 0.0, longitude: Double(model.infoModel[0].longitude) ?? 0.0)
        setMapFocus(centerCoordinate: location, radiusInKm: 0.5)
        addPins(centerCoordinate: location)

    }
    
    func setMapFocus(centerCoordinate: CLLocationCoordinate2D, radiusInKm radius: CLLocationDistance)
    {
        let diameter = radius * 2000
        let region: MKCoordinateRegion = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: diameter, longitudinalMeters: diameter)
        self.mapView.setRegion(region, animated: false)
    }
    func addPins(centerCoordinate: CLLocationCoordinate2D) {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        let ddPin = MKPointAnnotation()
        ddPin.title = "DD Space"
        ddPin.coordinate = centerCoordinate
        mapView.addAnnotation(ddPin)
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
        guard let model = model as? InfoCollectionViewModel, !model.infoModel.isEmpty else { return }
        model.output?.tapOnVk()
    }
    @objc
    private func telegramButtonAction() {
        guard let model = model as? InfoCollectionViewModel, !model.infoModel.isEmpty else { return }
        model.output?.tapOnTelegram()
    }
    @objc
    private func instagramButtonAction() {
        guard let model = model as? InfoCollectionViewModel, !model.infoModel.isEmpty else { return }
        model.output?.tapOnInstagram()
    }
    @objc
    private func phoneButtonAction() {
        guard let model = model as? InfoCollectionViewModel, !model.infoModel.isEmpty else { return }
        model.output?.tapOnPhone()
    }
    @objc
    private func addressButtonAction() {
        guard let model = model as? InfoCollectionViewModel, !model.infoModel.isEmpty else { return }
        model.output?.tapOnMap()
    }
    @objc
    private func emailButtonAction() {
        guard let model = model as? InfoCollectionViewModel, !model.infoModel.isEmpty else { return }
        model.output?.tapOnEmail()
    }
}
