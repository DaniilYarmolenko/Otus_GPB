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
    internal var unRegisterButton = UIButton()
    internal var tokenImageButton = UIButton()//MARK: make auth
    internal var VStackButton = UIStackView()
    
    private var imageEvent: UIImage?
    private var images = [UIImage]()
    let animationDuration: TimeInterval = 0.4
    let switchingInterval: TimeInterval = 8
    var index = 0
    var transition = CATransition()
    
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
        setUpTokenImageButton()
        setUpStackButton()
        setUpUnRegisterButton()
        setUpImageEvent()
    }
    
    private func setUpImageEvent() {
        imageEventView.clipsToBounds = true
        imageEventView.layer.cornerRadius = 15
        imageEventView.image = UIImage(named: "dd")
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
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
    private func setUpUnRegisterButton() {
        unRegisterButton.setBackgroundColor(color: .black, forState: .normal)
        unRegisterButton.setBackgroundColor(color: .blue, forState: .highlighted)
        unRegisterButton.setTitleColor(.white, for: .normal)
        unRegisterButton.setTitleColor(.white, for: .highlighted)
        unRegisterButton.setTitle("Я не смогу прийти", for: .normal)
        unRegisterButton.addTarget(self, action: #selector(tapOnUnRegisterButton), for: .touchUpInside)
        unRegisterButton.clipsToBounds = true
        unRegisterButton.layer.cornerRadius = 15
    }
    private func animateImageView() {
        //Begin the CATransaction
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.switchingInterval) {[weak self] in
                self?.animateImageView()
            }
        }
        
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        /*
         transition.type = CATransitionType.fade
         transition.subtype = CATransitionSubtype.fromRight
         */
        
        imageEventView.layer.add(transition, forKey: kCATransition)
        if images.count != 0 {
            imageEventView.image = images[index]
        }
        CATransaction.commit()
        index = index < images.count-1 ? index+1 : 0
    }
    private func setUpStackButton() {
        VStackButton.isHidden = true
        VStackButton.axis  = .vertical
        VStackButton.addArrangedSubview(
            CreateStack.createStack(
                axis: .vertical,
                distribution: .fillEqually,
                alignmentStack: .center,
                spacing: 5,
                views: tokenImageButton, unRegisterButton)
        )
        view.addSubview(VStackButton)
    }
    
    private func setUpTokenImageButton() {
        tokenImageButton.addTarget(self, action: #selector(tapOnQRcodeButton), for: .touchUpInside)
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
        if let imageToken = imageToken {
            tokenImageButton.setImage(imageToken, for: .normal)
            VStackButton.isHidden = false
            registerButton.isHidden = true
        }
        nameLabel.text = model.nameEvent
        authorLabel.text = model.authorName
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        dateLabel.text = "\(dateFormatter.string(from: model.dateStart.toDate())) – \(dateFormatter.string(from: model.dateEnd.toDate()))"
        textView.text = model.description
        guard !model.photos.isEmpty else {return}
        self.animateImageView()
        model.photos.forEach { photo in
            DispatchQueue.global().async {
                ImageLoader.shared.image(with: photo, folder: "EventPictures") { image in
                    DispatchQueue.main.async {
                        self.images.append(image ?? UIImage())
                    }
                }
            }
            self.imageEventView.image = self.images.first
        }
    }
}

extension EventDetailViewController {
    internal func addConstraints() {
        imageEventView.translatesAutoresizingMaskIntoConstraints = false
        imageEventView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageEventView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageEventView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/4).isActive = true
        imageEventView.widthAnchor.constraint(equalToConstant: SizeConstants.screenHeight/2).isActive = true
        
        
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
