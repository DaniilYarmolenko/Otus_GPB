//
//  CoreDataPageViewController.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import UIKit

final class CoreDataPageViewController: UIViewController {
    private let output: CoreDataPageViewOutput
    internal var emptyCoreDataView =  EmptyView(titleText: "Core Data пуста",subtitleText: "Добавьте в Core Data на главной странице, чтобы тут не было пусто :(", imageString: "emptyDB")
    internal var searchBar = UISearchBar()
    internal var tableView =  UITableView()
    internal var deleteAllButton = UIButton()
    init(output: CoreDataPageViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        [emptyCoreDataView, tableView, deleteAllButton, searchBar].forEach { [weak self] view in
            self?.view.addSubview(view)
        }
        setUp()
        output.viewDidLoad()
    }
    private func setUp() {
        setUpTableView()
        setUpButton()
        setUpSearchBar()
        self.title = "CoreData"
        self.view.backgroundColor = .white
    }

    private func setUpButton() {
        deleteAllButton.backgroundColor = .clear
        deleteAllButton.layer.borderColor = UIColor.red.cgColor
        deleteAllButton.layer.borderWidth = 2.0
        deleteAllButton.setTitle("Удалить все", for: .normal)
        deleteAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
        deleteAllButton.setTitleColor(.red, for: .normal)
        deleteAllButton.addTarget(self, action: #selector(deleteAlert), for: .touchUpInside)
    }
    @objc
    private func deleteAlert() {
        output.deleteAll()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewDidLoad()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addViewConstraints()
    }
    private func setUpSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.layer.cornerRadius = 10
        self.searchBar.barTintColor = .white
        self.searchBar.placeholder = "Введите имя для поиска"
    }
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.tableFooterView = UIView()
        self.tableView.tableFooterView?.frame.size.height = 100
        self.tableView.register(CoreDataCell.self, forCellReuseIdentifier: CoreDataCell.cellIdentifier)
    }
}

extension CoreDataPageViewController: CoreDataPageViewInput {
    func loadData() {
        if output.checkEmpty() {
            self.emptyCoreDataView.isHidden = false
            self.tableView.isHidden = true
            self.deleteAllButton.isHidden = true
        } else {
            self.emptyCoreDataView.isHidden = true
            self.tableView.isHidden = false
            self.deleteAllButton.isHidden = false
        }
        tableView.reloadData()
    }
    
}
extension CoreDataPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getCellsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CoreDataCell") as? CoreDataCell else { return UITableViewCell() }
        cell.delegate = output
        cell.model = output.getCell(id: indexPath.row)
        return cell
    }
}
extension CoreDataPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.filteringDataByName(with: searchText)
    }
}
