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
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        output.viewDidLoad()
        setUp()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    private func setUp() {
        setUpImageEvent()
        setUpLabels()
        setUpTextView()
        setUpRegisterButton()
        setUpTokenImageButton()
        setUpStackButton()
        setUpUnRegisterButton()
    }
    
    private func setUpImageEvent() {
        imageEventView.image = UIImage(named: "noData")
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
        if imageEvent == nil {
            DispatchQueue.global().async {
                ImageLoader.shared.image(with: model.photos[0], folder: "EventPictures") { image in
                    DispatchQueue.main.async {
                        self.imageEvent = image
                        self.imageEventView.image = image
                    }
                }
            }
        }
        
    }
}

extension EventDetailViewController {
    internal func addConstraints() {
        imageEventView.translatesAutoresizingMaskIntoConstraints = false
        imageEventView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        imageEventView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        imageEventView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageEventView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/2.5).isActive = true
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/7).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -SizeConstants.screenHeight/7 - 8).isActive = true
        textView.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
        textView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/2).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.textView.topAnchor, constant: -8).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/12).isActive = true
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: -8).isActive = true
        authorLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/12).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.authorLabel.topAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.imageEventView.bottomAnchor, constant: 8).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
        
        VStackButton.translatesAutoresizingMaskIntoConstraints = false
        VStackButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        VStackButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        VStackButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
        VStackButton.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/7).isActive = true
    }
}
