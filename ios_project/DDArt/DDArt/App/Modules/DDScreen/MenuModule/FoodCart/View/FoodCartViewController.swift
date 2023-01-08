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
    internal var emptyCoreDataView =  EmptyView(titleText: "Корзина пуста",subtitleText: "Добавьте в Корзину на странице с меню, чтобы тут не было пусто :(", imageString: "emptyDB")
    internal var tableView =  UITableView()
    internal var totalAmountLabel = UILabel()
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
        [emptyCoreDataView, tableView].forEach { [weak self] view in
            self?.view.addSubview(view)
        }
        setUp()
        output.viewDidLoad()
    }
    private func setUp() {
        setUpTableView()
        setUpTotalAmountLabel()
        self.title = "Cart"
        self.view.backgroundColor = .white
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewDidLoad()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addViewConstraints()
    }
    private func setUpTotalAmountLabel() {
        totalAmountLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 50)
    }
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.tableFooterView = UIView()
        self.tableView.tableFooterView?.frame.size.height = 100
        self.tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.cellIdentifier)
    }
}

extension FoodCartViewController: FoodCartViewInput {
    func loadData() {
        if output.checkEmpty() {
            self.emptyCoreDataView.isHidden = false
            self.tableView.isHidden = true
//            self.deleteAllButton.isHidden = true
        } else {
            self.emptyCoreDataView.isHidden = true
            self.tableView.isHidden = false
//            self.deleteAllButton.isHidden = false
        }
        totalAmountLabel.attributedText = "\(self.output.getTotalAmount()) ₽".underLined
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
        self.emptyCoreDataView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        self.emptyCoreDataView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.emptyCoreDataView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.emptyCoreDataView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
