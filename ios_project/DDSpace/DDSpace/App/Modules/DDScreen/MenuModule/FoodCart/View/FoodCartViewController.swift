//
//  FoodCartViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class FoodCartViewController: UIViewController {
    private let output: FoodCartViewOutput
    internal var emptyCoreDataView =  EmptyView(titleText: "Корзина пуста",subtitleText: "Добавьте в Корзину на странице с меню, чтобы тут не было пусто :(", imageString: "emptyCart")
    internal var tableView =  UITableView()
    internal var totalAmountLabel = UILabel()
    let btn = BadgedButtonItem(with: UIImage(named: "trash"))
    internal var orderButton = UIButton()
    init(output: FoodCartViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [emptyCoreDataView, tableView, totalAmountLabel].forEach { [weak self] view in
            self?.view.addSubview(view)
        }
        setUp()
        output.viewDidLoad()
    }
    private func setUp() {
        setUpTableView()
        setUpTotalAmountLabel()
        setUpOrderButton()
        self.title = "Cart"
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = btn
        self.view.backgroundColor = .white
        btn.tapAction = { [weak self] in
            self?.output.deleteAllAlert()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewDidLoad()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addViewConstraints()
    }
    private func setUpOrderButton() {
        orderButton.setTitle("Заказать ?", for: .normal)
        orderButton.setTitleColor(.white, for: .normal)
        orderButton.setBackgroundColor(color: .black, forState: .normal)
        orderButton.setBackgroundColor(color: .blue, forState: .highlighted)
        orderButton.addTarget(self, action: #selector(clickOnOrderButton), for: .touchUpInside)
        orderButton.layer.cornerRadius = 10
        view.addSubview(orderButton)
    }
    private func setUpTotalAmountLabel() {
        totalAmountLabel.textAlignment = .center
        totalAmountLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 22)
    }
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.cellIdentifier)
    }
    @objc
    func clickOnOrderButton() {
        output.clickOnOrderButton()
    }
}

extension FoodCartViewController: FoodCartViewInput {
    func loadData() {
        if output.checkEmpty() {
            self.emptyCoreDataView.isHidden = false
            self.tableView.isHidden = true
            self.totalAmountLabel.isHidden = true
            self.orderButton.isHidden = true
            navigationItem.rightBarButtonItem = nil
        } else {
            self.emptyCoreDataView.isHidden = true
            self.tableView.isHidden = false
            self.totalAmountLabel.isHidden = false
            self.orderButton.isHidden = false
            navigationItem.rightBarButtonItem = btn
        }
        totalAmountLabel.attributedText = "Общая сумма заказа \(self.output.getTotalAmount()) ₽".underLined
        tableView.reloadData()
    }
    
}
extension FoodCartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getCellsCount()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CartCell") as? CartCell else { return UITableViewCell() }
        cell.delegate = output
        cell.model = output.getCell(id: indexPath.row)
        cell.selectionStyle = .none
        cell.configure(model: output.getCell(id: indexPath.row))
        return cell
    }
}
extension FoodCartViewController {
    func addViewConstraints() {
        self.emptyCoreDataView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyCoreDataView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.emptyCoreDataView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.emptyCoreDataView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.emptyCoreDataView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.totalAmountLabel.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 4).isActive = true
        self.totalAmountLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.totalAmountLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.totalAmountLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth/2).isActive = true
        
        self.orderButton.translatesAutoresizingMaskIntoConstraints = false
        self.orderButton.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 4).isActive = true
        self.orderButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.orderButton.leadingAnchor.constraint(equalTo: self.totalAmountLabel.trailingAnchor, constant: 10).isActive = true
        self.orderButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
    }
}
