//
//  CartViewController.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import UIKit

final class CartViewController: UIViewController {
	private let output: CartViewOutput
    internal var emptyCartView =  EmptyCartView()
    internal var tableView =  UITableView()
    internal var goAlertButton = UIButton()
    private var activityIndicatorView: UIActivityIndicatorView!
    init(output: CartViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        [emptyCartView, tableView, goAlertButton].forEach { [weak self] view in
            self?.view.addSubview(view)
        }
        setUp()
        output.viewDidLoad()
	}
    private func setUp() {
        setUpTableView()
        setUpButton()
        setUpIndicator()
        self.title = "Корзина"
        self.view.backgroundColor = .lightGray
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    private func setUpIndicator() {
        var frameCenter = view.center
        frameCenter.x -= 25
        frameCenter.y -= 25
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.center = frameCenter
        activityIndicatorView.tintColor = .orange
    }
    private func setUpButton() {
        goAlertButton.backgroundColor = .cyan
        goAlertButton.setTitle("Заказать", for: .normal)
        goAlertButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
        goAlertButton.addTarget(self, action: #selector(goAlert), for: .touchUpInside)
    }
    @objc
    private func goAlert() {
        output.goToCheckout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewDidLoad()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addViewConstraints()
    }
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.tableFooterView = UIView()
        self.tableView.tableFooterView?.frame.size.height = 100
        self.tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.cellIdentifier)
    }
}

extension CartViewController: CartViewInput {
    func loadData() {
        if output.checkEmpty() {
            self.emptyCartView.isHidden = false
            self.tableView.isHidden = true
            self.goAlertButton.isHidden = true
        } else {
            self.emptyCartView.isHidden = true
            self.tableView.isHidden = false
            self.goAlertButton.isHidden = false
        }
        activityIndicatorView.stopAnimating()
        tableView.reloadData()
    }
    
}
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getCellsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CartViewCell") as? CartTableViewCell else { return UITableViewCell() }
        cell.delegate = output
        cell.model = output.getCell(id: indexPath.row)
        return cell
    }
}

