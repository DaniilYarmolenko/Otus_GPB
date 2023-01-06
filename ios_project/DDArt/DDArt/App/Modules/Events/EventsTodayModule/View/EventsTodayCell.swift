//
//  EventsTodayCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 11.12.2022.
//

import Foundation
import UIKit
final class EventsTodayCell: UITableViewCell {
    static let cellIdentifier = String(describing: EventsTodayCell.self)
    var cellViews: (frontView: UIView, backView: UIView)?
    internal var imageEventView = UIImageView()
    internal var infoView = UIView()
    internal var nameLabel = UILabel()
    internal var authorLabel = UILabel()
    internal var dateEvent = UILabel()
    internal var registerButton = UIButton()
    internal var reverseButton = UIButton()
    internal var imageName: String?
    internal var imageLoaded: UIImage?
    private var id: UUID?
    var delegate: EventsTodayViewOutput?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setUp()
        addConstraintImageEventView()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        setUpReverseButton()
        setUpImageView()
        setUpInfoView()
        setUpLabels()
        setUpRegisterButton()
        addConstraintImageEventView()
    }
    
    private func setUpInfoView() {
        infoView.backgroundColor = .white
    }
    
    
    func flipCardAnimation() {
        if (infoView.superview != nil) {
            cellViews = (frontView: imageEventView, backView: infoView)
        } else {
            cellViews = (frontView: infoView, backView: imageEventView)
        }
        
        let transitionOptions = UIView.AnimationOptions.transitionFlipFromLeft
        UIView.transition(with: self.contentView, duration: 0.5, options: transitionOptions, animations: {
            if self.cellViews!.backView == self.infoView {
                self.contentView.removeConstraints([
                    self.infoView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    self.infoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                    self.infoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                    self.infoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                    
                    self.nameLabel.topAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 10),
                    self.nameLabel.centerXAnchor.constraint(equalTo: self.infoView.centerXAnchor),
                    self.nameLabel.heightAnchor.constraint(equalToConstant: self.infoView.bounds.height/4),
                    self.nameLabel.widthAnchor.constraint(equalToConstant: self.infoView.bounds.width - 10),
                    
                    self.dateEvent.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10),
                    self.dateEvent.centerXAnchor.constraint(equalTo: self.infoView.centerXAnchor),
                    self.dateEvent.heightAnchor.constraint(equalToConstant: self.infoView.bounds.height/4),
                    self.dateEvent.widthAnchor.constraint(equalToConstant: self.infoView.bounds.width - 10),
                    
                    self.registerButton.topAnchor.constraint(equalTo: self.dateEvent.bottomAnchor, constant: 10),
                    self.registerButton.centerXAnchor.constraint(equalTo: self.infoView.centerXAnchor),
                    self.registerButton.bottomAnchor.constraint(equalTo: self.infoView.bottomAnchor, constant: -10),
                    self.registerButton.heightAnchor.constraint(equalToConstant: self.infoView.bounds.height/4),
                    self.registerButton.widthAnchor.constraint(equalToConstant: self.infoView.bounds.width - 10)
                ])
                [self.nameLabel, self.reverseButton, self.authorLabel, self.dateEvent, self.registerButton].forEach { $0.removeFromSuperview() //, self.authorLabel, self.dateEvent
                }
            } else {
                self.contentView.removeConstraints([
                    self.imageEventView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    self.imageEventView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                    self.imageEventView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                    self.imageEventView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
                ])
                self.reverseButton.removeFromSuperview()
            }
            self.cellViews!.backView.removeFromSuperview()
            if self.cellViews!.frontView == self.infoView {
                self.contentView.addSubview(self.infoView)
                [self.nameLabel, self.reverseButton, self.authorLabel, self.dateEvent, self.registerButton].forEach { self.infoView.addSubview($0)}
                self.addConstraintsInfoView()
            } else {
                self.contentView.addSubview(self.imageEventView)
                self.contentView.addSubview(self.reverseButton)
                self.addConstraintImageEventView()
            }
            self.contentView.backgroundColor = .white
        }, completion: { finished in
        })
    }
    private func setUpImageView() {
        contentView.backgroundColor = UIColor.white
        imageEventView.clipsToBounds = true
        layer.masksToBounds = true
        self.clipsToBounds = true
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2.0
        contentView.layer.cornerRadius = 15
        contentView.layer.backgroundColor = UIColor.white.cgColor
        imageEventView.layer.cornerRadius = 15
        self.contentView.addSubview(imageEventView)
        self.contentView.addSubview(reverseButton)
        reverseButton.addTarget(self, action: #selector(tapOnReverseButton), for: .touchUpInside)
    }
    
    private func setUpRegisterButton() {
        registerButton.setBackgroundColor(color: .black, forState: .normal)
        registerButton.setBackgroundColor(color: .blue, forState: .highlighted)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setTitleColor(.white, for: .highlighted)
        registerButton.setTitle("Получить билет", for: .normal)
        registerButton.addTarget(self, action: #selector(tapOnRegisterButton), for: .touchUpInside)
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 15
    }

    private func setUpReverseButton() {
        reverseButton.setBackgroundColor(color: .white, forState: .normal)
        reverseButton.setBackgroundColor(color: .white, forState: .highlighted)
        reverseButton.setImage(UIImage(named: "reverse"), for: .normal)
        reverseButton.setImage(UIImage(named: "reverse"), for: .highlighted)
        reverseButton.clipsToBounds = true
        reverseButton.layer.cornerRadius = 5
    }
    private func setUpLabels() {
        nameLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 36)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        authorLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 24)
        authorLabel.textColor = .black
        authorLabel.textAlignment = .center
        dateEvent.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 24)
        dateEvent.textColor = .black
        dateEvent.textAlignment = .center
    }
    
    @objc
    private func tapOnRegisterButton() {
        delegate?.clickOnRegisterButton(with: id)
    }
    
    @objc
    private func tapOnReverseButton() {
        flipCardAnimation()
    }
    
    func configure(model: EventModel, complition: @escaping () -> (Bool)) {
        nameLabel.attributedText = model.nameEvent.underLined
        authorLabel.attributedText = model.authorName.underLined
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        dateEvent.text = "\(dateFormatter.string(from: model.dateStart.toDate())) – \(dateFormatter.string(from: model.dateEnd.toDate()))"
        self.id = model.id
        self.imageEventView.image = imageLoaded ?? UIImage(named: "noData")
        guard !model.photos.isEmpty else {return}
        if imageName != model.photos[0] {
            DispatchQueue.global().async {
                ImageLoader.shared.image(with: model.photos[0], folder: "EventPictures") { image in
                    DispatchQueue.main.async {
                        if !complition() { return }
                        self.imageEventView.image = image
                        self.imageName = model.photos[0]
                        self.imageLoaded = image
                    }
                }
            }
        }
    }
}
