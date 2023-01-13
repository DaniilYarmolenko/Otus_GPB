//
//  NewsDetailViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class NewsDetailViewController: UIViewController {
    private let output: NewsDetailViewOutput
    internal var imageNewsView = UIImageView()
    internal var textView = UITextView()
    internal var nameLabel = UILabel()
    internal var titleLabel = UILabel()
    internal var scrollView = UIScrollView()
    private var imageNews: UIImage?
    
    private var images = [UIImage]()
    let animationDuration: TimeInterval = 0.4
    let switchingInterval: TimeInterval = 5
    var index = 0
    var transition = CATransition()
    private let dispatchQueue = DispatchQueue(label: "loadImageNews")
    private let dispatchSemaphore = DispatchSemaphore(value: 0)
    private let group = DispatchGroup()
    init(output: NewsDetailViewOutput) {
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
        navigationController?.isNavigationBarHidden = false
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
        setUpImageNews()
    }
    private func setUpScroll() {
        
    }
    private func setUpImageNews() {
        imageNewsView.clipsToBounds = true
        imageNewsView.layer.cornerRadius = 15
        self.view.addSubview(imageNewsView)
    }
    private func setUpLabels() {
        nameLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 36)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        titleLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 24)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        [nameLabel, titleLabel].forEach{view.addSubview($0)}
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
            
            imageNewsView.layer.add(transition, forKey: kCATransition)
            if images.count != 0 {
                imageNewsView.image = images[index]
            }
            CATransaction.commit()
            index = index < images.count-1 ? index+1 : 0
        } else if images.isEmpty {
            imageNewsView.image = UIImage(named: "ddLarge")
        } else {
            imageNewsView.image = self.images.first
        }
    }
}

extension NewsDetailViewController: NewsDetailViewInput {
    func loadData(model: NewsModel) {
        nameLabel.text = model.newsName
        titleLabel.text = model.titleNews
        textView.text = model.description
        if !model.photos.isEmpty {
            dispatchQueue.async {
                model.photos.forEach { photo in
                    self.group.enter()
                    ImageLoader.shared.image(with: photo, folder: "NewsPictures") { image in
                        self.images.append((image ?? UIImage(named: "ddLarge")) ?? UIImage())
                        DispatchQueue.main.async {
                            self.imageNewsView.image = self.images.first
                        }
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
        } else {
            imageNewsView.image = UIImage(named: "ddLarge")
        }
    }
    
}

extension NewsDetailViewController {
    internal func addConstraints() {
        
        imageNewsView.translatesAutoresizingMaskIntoConstraints = false
        imageNewsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageNewsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageNewsView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/4).isActive = true
        imageNewsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.imageNewsView.bottomAnchor, constant: 8).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth - 30).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth - 30).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 16).isActive = true
        textView.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth - 30).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
    }
}

