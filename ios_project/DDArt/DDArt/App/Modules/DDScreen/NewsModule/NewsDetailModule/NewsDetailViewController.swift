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
        imageNewsView.image = UIImage(named: "noData")
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
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
        textView.showsVerticalScrollIndicator = false
        self.view.addSubview(textView)
    }
}

extension NewsDetailViewController: NewsDetailViewInput {
    func loadData(model: NewsModel) {
        nameLabel.text = model.newsName
        titleLabel.text = model.titleNews
        textView.text = model.description
        guard !model.photos.isEmpty else {return}
        DispatchQueue.global().async {
            ImageLoader.shared.image(with: model.photos[0], folder: "EventPictures") { image in
                DispatchQueue.main.async {
                    self.imageNews = image
                    self.imageNewsView.image = image
                }
            }
        }
    }
    
}

extension NewsDetailViewController {
    internal func addConstraints() {
        
        imageNewsView.translatesAutoresizingMaskIntoConstraints = false
        imageNewsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        imageNewsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        imageNewsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageNewsView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/3).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.imageNewsView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}

