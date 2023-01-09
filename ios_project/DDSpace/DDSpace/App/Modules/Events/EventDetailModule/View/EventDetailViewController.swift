//
//  EventDetailViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.12.2022.
//  
//

import UIKit

final class EventDetailViewController: UIViewController {
    private let output: EventDetailViewOutput
    
    internal var imageEventView = UIImageView()
    internal var textView = UITextView()
    internal var nameLabel = UILabel()
    internal var authorLabel = UILabel()
    internal var dateLabel = UILabel()
    internal var registerButton = UIButton()
    
    private var imageEvent: UIImage?
    private var images = [UIImage]()
    let animationDuration: TimeInterval = 0.4
    let switchingInterval: TimeInterval = 5
    var index = 0
    var transition = CATransition()
    private let dispatchQueue = DispatchQueue(label: "loadImage")
    private let dispatchSemaphore = DispatchSemaphore(value: 0)
    private let group = DispatchGroup()
    
    init(output: EventDetailViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        view.backgroundColor = .white
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    private func setUp() {
        setUpLabels()
        setUpTextView()
        setUpRegisterButton()
        setUpImageEvent()
    }
    
    private func setUpImageEvent() {
        imageEventView.clipsToBounds = true
        imageEventView.layer.cornerRadius = 15
        self.view.addSubview(imageEventView)
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
        [nameLabel, authorLabel, dateLabel].forEach{view.addSubview($0)}
    }
    
    private func setUpTextView() {
        textView.font = UIFont(name: FontConstants.MoniqaLightItalicHeading, size: 24)
        textView.textColor = .black
        textView.isEditable = false
        textView.textAlignment = .center
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
        textView.showsVerticalScrollIndicator = false
        self.view.addSubview(textView)
    }
    
    private func setUpRegisterButton() {
        registerButton.setBackgroundColor(color: .black, forState: .normal)
        registerButton.setBackgroundColor(color: .blue, forState: .highlighted)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setTitleColor(.white, for: .highlighted)
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.addTarget(self, action: #selector(tapOnRegisterButton), for: .touchUpInside)
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 15
        view.addSubview(registerButton)
    }
    private func animateImageView() {
        if images.count > 1 {
            CATransaction.begin()
            CATransaction.setAnimationDuration(animationDuration)
            CATransaction.setCompletionBlock {
                DispatchQueue.main.asyncAfter(deadline: .now() + self.switchingInterval) {[weak self] in
                    self?.animateImageView()
                }
            }
            
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            imageEventView.layer.add(transition, forKey: kCATransition)
            if images.count != 0 {
                imageEventView.image = images[index]
            }
            CATransaction.commit()
            index = index < images.count-1 ? index+1 : 0
        } else {
            imageEventView.image = self.images.first
        }
    }
    
    @objc
    private func tapOnRegisterButton() {
        if Auth().token == nil {
            output.showAlertAuth()
        } else {
            output.showOpsAlert()
        }
    }
    @objc
    private func tapOnUnRegisterButton() {
        
    }
    @objc
    private func tapOnQRcodeButton() {
        
    }
    
}

extension EventDetailViewController: EventDetailViewInput {
    func loadData(model: EventModel, imageToken: UIImage?){
        nameLabel.text = model.nameEvent
        authorLabel.text = model.authorName
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        dateLabel.text = "\(dateFormatter.string(from: model.dateStart.toDate())) – \(dateFormatter.string(from: model.dateEnd.toDate()))"
        textView.text = model.description
        guard !model.photos.isEmpty else {return}
        dispatchQueue.async {
            
            model.photos.forEach { photo in
                self.group.enter()
                ImageLoader.shared.image(with: photo, folder: "EventPictures") { image in
                    self.images.append((image ?? UIImage(named: "ddLarge")) ?? UIImage())
//                    DispatchQueue.main.async {
//                        self.imageEventView.image = self.images.first
//                    }
                    self.dispatchSemaphore.signal()
                    self.group.leave()
                }
                self.dispatchSemaphore.wait()
            }
        }
        group.notify(queue: dispatchQueue, execute: { [self] in
            DispatchQueue.main.async {
                self.animateImageView()
            }
        })
    }
}

extension EventDetailViewController {
    internal func addConstraints() {
        imageEventView.translatesAutoresizingMaskIntoConstraints = false
        imageEventView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageEventView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageEventView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/4).isActive = true
        imageEventView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.imageEventView.bottomAnchor, constant: 8).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth - 30).isActive = true
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        authorLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 4).isActive = true
        authorLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth - 30).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 16).isActive = true
        textView.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth - 30).isActive = true
        textView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/3).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 8).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth - 30).isActive = true
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/15).isActive = true
    }
}
