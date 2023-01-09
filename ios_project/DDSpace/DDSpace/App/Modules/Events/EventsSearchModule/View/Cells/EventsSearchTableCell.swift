//
//  EventsSearchTableCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 11.12.2022.
//

import Foundation
import UIKit

final class EventsSearchTableCell: UITableViewCell {
    static let cellIdentifier = String(describing: EventsSearchTableCell.self)
    var delegate: EventsSearchViewOutput?
    internal var eventImage = UIImageView()
    internal var nameLabel = UILabel()
    internal var authorLabel = UILabel()
    internal var dateLabel = UILabel()
    
    internal var image: UIImage?
    var id: UUID?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addConstraints()
    }
    
    private func setUp() {
        setUpLabels()
        setUpImage()
    }
    
    private func setUpLabels() {
        nameLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 36)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        authorLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 24)
        authorLabel.textColor = .black
        authorLabel.textAlignment = .center
        dateLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 24)
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        [nameLabel, authorLabel, dateLabel].forEach { self.contentView.addSubview($0) }
    }
    
    private func setUpImage() {
        contentView.backgroundColor = UIColor.white
        eventImage.clipsToBounds = true
        layer.masksToBounds = true
        self.clipsToBounds = true
        eventImage.contentMode = .scaleAspectFill
        contentView.layer.cornerRadius = 20
        eventImage.layer.cornerRadius = 5
        self.contentView.addSubview(eventImage)
    }
    
    func configure(model: EventModel, complition: @escaping () -> (Bool)) {
        nameLabel.attributedText = model.nameEvent.underLined
        authorLabel.attributedText = model.authorName.underLined
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        dateLabel.text = "\(dateFormatter.string(from: model.dateStart.toDate())) – \(dateFormatter.string(from: model.dateEnd.toDate()))"
        self.id = model.id
    }
}

extension EventsSearchTableCell {
    internal func addConstraints() {
        self.eventImage.translatesAutoresizingMaskIntoConstraints = false
        self.eventImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.eventImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.eventImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        self.eventImage.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
//        self.eventImage.heightAnchor.constraint(equalToConstant: SizeConstants.screenWidth/3).isActive = true
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.leadingAnchor.constraint(equalTo: self.eventImage.trailingAnchor, constant: 8).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.eventImage.topAnchor).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: self.contentView.bounds.height/4).isActive = true
        
        
        self.authorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor).isActive = true
        self.authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.authorLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8).isActive = true
        self.authorLabel.heightAnchor.constraint(equalTo: self.nameLabel.heightAnchor).isActive = true
        
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor).isActive = true
        self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.dateLabel.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 8).isActive = true
        self.dateLabel.heightAnchor.constraint(equalTo: self.nameLabel.heightAnchor).isActive = true
    }
}
