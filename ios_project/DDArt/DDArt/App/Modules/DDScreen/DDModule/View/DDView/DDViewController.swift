//
//  DDViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class DDViewController: UIViewController {
    private let output: DDViewOutput
    internal var tableView =  UITableView()
    private let refreshControl = UIRefreshControl()
    //    private var activityIndicatorView: !
    init(output: DDViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        output.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraint()
    }
    private func setUp() {
        navigationController?.navigationBar.isHidden = true
        setUpTableView()
        //        setUpIndicator()
        
        self.view.backgroundColor = .white
//        self.view.addSubview(activityIndicatorView)
//        activityIndicatorView.startAnimating()
    }
    private func setUpTableView() {
        setUpTableViewBase()
        registerCells()
        setUpRefreshControll()
    }
    private func registerCells() {
        tableView.register(HeaderCellView.self, forCellReuseIdentifier: HeaderCellView.cellIdentifier)
        tableView.register(NewsCollectionTableViewCell.self, forCellReuseIdentifier: NewsCollectionTableViewCell.cellIdentifier)
        tableView.register(FoodCategoriesCollectionViewCell.self, forCellReuseIdentifier: FoodCategoriesCollectionViewCell.cellIdentifier)
        tableView.register(InfoViewCell.self, forCellReuseIdentifier: InfoViewCell.cellIdentifier)
    }
    private func setUpRefreshControll() {
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...", attributes: nil)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    private func setUpTableViewBase() {
        self.view.addSubview(tableView)
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
//        tableView.tableHeaderView = UIView()
        tableView.separatorStyle = .none
    }
    @objc
    func refreshData() {
        output.loadData()
        self.refreshControl.endRefreshing()
    }
}

extension DDViewController: DDViewInput {
    func reloadData() {
        self.refreshControl.endRefreshing()
        tableView.reloadData()
//        output.sectionDelegate = self
//        activityIndicatorView.stopAnimating()
    }
    
}

extension DDViewController: TableViewCellOutput {
    func tapMoreNews() {
        output.goToAllNews()
    }
    
    func tapMoreFood() {
        output.goToMenu()
    }
    
    func tapOnNews(with id: Int) {
        output.tapOnNews(with: id)
    }
    
    func tapOnCategory(with id: Int) {
        output.tapOnCategory(with: id)
    }
    
    func tapOnMap() {
        output.tapOnMap()
    }
    
    func tapOnPhone() {
        output.tapOnPhone()
    }
    
    func tapOnEmail() {
        output.tapOnEmail()
    }
    
    func tapOnVk() {
        output.tapOnVk()
    }
    
    func tapOnTelegram() {
        output.tapOnTelegram()
    }
    
    func tapOnInstagram() {
        output.tapOnInstagram()
    }
    

}

extension DDViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getCountCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: output.getCellIdentifier(at: indexPath.row), for: indexPath)
                as? BaseCell else {
            return UITableViewCell()
        }
        cell.model = output.getCell(at: indexPath.row)
        return cell
    }
}

extension DDViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(output.getCellHeight(at: indexPath.row))
    }
}
