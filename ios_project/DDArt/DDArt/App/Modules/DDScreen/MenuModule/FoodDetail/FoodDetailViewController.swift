//
//  FoodDetailViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class FoodDetailViewController: UIViewController {
	private let output: FoodDetailViewOutput
    internal var imageFoodView = UIImageView()
    internal var descriptionLabel = UILabel()
    internal var nameLabel = UILabel()
    internal var costLabel = UILabel()
    internal var stepper = UIStepper()
    internal var countLabel = UILabel()
    internal var stackView = UIStackView()
    private var image: UIImage?
    let number: Int = UserDefaults.standard.integer(forKey: "countCart")
    var count: Int?
    let btn = BadgedButtonItem(with: UIImage(named: "dd"))

    init(output: FoodDetailViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(changeBudged), name: NSNotification.Name("detailFoodBadge"), object: nil)
        view.backgroundColor = .white
        count = output.getFoodCountInCart()
        setUp()
        output.viewDidLoad()
	}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btn.setBadge(with: UserDefaults.standard.integer(forKey: "countCart"))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    private func setUp() {
        setUpLabels()
        setUpStepper()
        setUpImageFood()
        setUpNavigtion()
    }
    private func setUpImageFood() {
        imageFoodView.image = UIImage(named: "noData")
        imageFoodView.clipsToBounds = true
        imageFoodView.layer.cornerRadius = 15
        self.view.addSubview(imageFoodView)
    }
    private func setUpLabels() {
        nameLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 36)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        costLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 24)
        costLabel.textColor = .black
        costLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 24)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        countLabel.text = "\(output.getFoodCountInCart())"
        countLabel.textColor = .black
        countLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 24)
        stackView.addArrangedSubview(CreateStack.createStack(axis: .vertical, distribution: .fillProportionally, alignmentStack: .center, spacing: 10, views: nameLabel, costLabel, descriptionLabel))
        view.addSubview(countLabel)
        view.addSubview(stackView)
    }
    private func setUpStepper() {
        stepper.minimumValue = 0
        stepper.value = Double(output.getFoodCountInCart())
        stepper.addTarget(self, action: #selector(changeValueStepper), for: .valueChanged)
        stepper.contentVerticalAlignment = .center
        stepper.contentHorizontalAlignment = .center
    
        view.addSubview(stepper)
    }
    private func setUpNavigtion() {
        navigationController?.navigationBar.isHidden = false
//        navigationItem.title = output
        navigationItem.rightBarButtonItem = btn
        btn.tapAction = {
            self.output.goToCart()
        }
    }
    @objc
    func changeValueStepper() {
//        UserDefaults.standard.set(number+Int(stepper.value), forKey: "countCart")
        switch output.getFoodCountInCart() {
        case 0:
            self.output.addToCoreData(image: image?.pngData() ?? Data())
        case 1:
            if stepper.value == 0 {
                self.output.deleteFromCoreData()
            } else {
                self.output.updateFood(image: image?.pngData() ?? Data(), value: Int(stepper.value))
            }
        default:
            self.output.updateFood(image: image?.pngData() ?? Data(), value: Int(stepper.value))
        }
        NotificationCenter.default.post(name: NSNotification.Name("cartBadge"), object: nil)
        self.btn.setBadge(with: UserDefaults.standard.integer(forKey: "countCart"))
        countLabel.text = "\(Int(stepper.value))"
    }
    @objc
    func changeBudged() {
        stepper.value = Double(output.getFoodCountInCart())
        self.btn.setBadge(with: UserDefaults.standard.integer(forKey: "countCart"))
        countLabel.text = "\(Int(stepper.value))"
    }
    
}

extension FoodDetailViewController: FoodDetailViewInput {
    func updateData(food: FoodModel) {
        nameLabel.text = food.nameFood
        descriptionLabel.text = food.description
        costLabel.text = "\(food.cost) ₽"
        guard !food.photos.isEmpty else {return}
        DispatchQueue.global().async {
            ImageLoader.shared.image(with: food.photos[0], folder: "FoodPictures") { image in
                DispatchQueue.main.async {
                    self.image = image
                    self.imageFoodView.image = image
                }
            }
        }
    }
    
}
extension FoodDetailViewController {
    internal func addConstraints() {
        imageFoodView.translatesAutoresizingMaskIntoConstraints = false
        imageFoodView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        imageFoodView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        imageFoodView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageFoodView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/2.5).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: self.imageFoodView.bottomAnchor, constant: 10).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/4).isActive = true
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stepper.widthAnchor.constraint(equalToConstant: 120).isActive = true
        stepper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        stepper.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.leadingAnchor.constraint(equalTo: stepper.trailingAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        countLabel.topAnchor.constraint(equalTo: stepper.topAnchor).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: stepper.bottomAnchor).isActive = true
    }
}
