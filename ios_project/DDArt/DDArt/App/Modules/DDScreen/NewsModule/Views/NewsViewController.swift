//
//  NewsViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class NewsViewController: UIViewController {
	private let output: NewsViewOutput
    private let refreshControl = UIRefreshControl()
    internal var tableViewNews = UITableView()
    init(output: NewsViewOutput) {
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
        navigationItem.title = "News"
        view.backgroundColor = .white
        setUp()
        output.viewDidLoad()
	}
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraints()
    }
    private func setUp() {
        setUpTableViewBase()
    }
    private func setUpTableViewBase() {
        tableViewNews.showsVerticalScrollIndicator = false
        tableViewNews.delegate = self
        tableViewNews.refreshControl = refreshControl
        tableViewNews.dataSource = self
        tableViewNews.separatorStyle = .singleLine
        tableViewNews.separatorColor = .black
        tableViewNews.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellIdentifier)
        
        tableViewNews.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableViewNews)
    }
}

extension NewsViewController: NewsViewInput {
    func reloadData() {
            self.tableViewNews.reloadData()
    }
}
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.getCountNewsCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellIdentifier, for: indexPath) as? NewsCell else { return UITableViewCell() }
        cell.configure(model: output.getNewsCell(with: indexPath.row)) {
            let myCell = tableView.cellForRow(at: indexPath)
            return cell == myCell
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SizeConstants.screenHeight/4
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.clickOnNews(with: indexPath.row)
        
    }
}
extension NewsViewController {
    internal func addConstraints() {
        tableViewNews.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableViewNews.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableViewNews.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        tableViewNews.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
}
