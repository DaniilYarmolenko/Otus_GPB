//
//  EventsTodayViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsTodayViewController: UIViewController {
    private let output: EventsTodayViewOutput
    internal var emptyView =  EmptyView(titleText: "Сегодня событий нет(",subtitleText: "Но вы все равно к нам заглядывайте!", imageString: "emptyDB")
    internal var tableView = UITableView()
    private let dispatchSemaphore = DispatchSemaphore(value: 0)
    private let refreshControl = UIRefreshControl()
    init(output: EventsTodayViewOutput) {
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
        view.addSubview(emptyView)
        addConstraints()
    }
    private func setUp() {
        setUpTableViewBase()
        setUpBase()
        setUpRefreshControll()
    }
    private func setUpBase() {
        self.view.backgroundColor = .white
    }
    
    private func setUpTableViewBase() {
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.register(EventsTodayCell.self, forCellReuseIdentifier: EventsTodayCell.cellIdentifier)
        view.addSubview(tableView)
    }
    private func setUpRefreshControll() {
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...", attributes: nil)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc
    func refreshData() {
        output.loadData()
    }
}

extension EventsTodayViewController: EventsTodayViewInput {
    func reloadData() {
        tableView.reloadData()
        if output.getCountCell() == 0 {
            self.emptyView.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.emptyView.isHidden = true
            self.tableView.isHidden = false
        }
        self.refreshControl.endRefreshing()
    }
    
}

extension EventsTodayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.getCountCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SizeConstants.screenHeight/3.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsTodayCell.cellIdentifier, for: indexPath) as? EventsTodayCell else { return UITableViewCell() }
        let model = output.getCell(with: indexPath.row)
        cell.configure(model: model) {
            let myCell = tableView.cellForRow(at: indexPath)
            return cell == myCell
        }
        if !model.photos.isEmpty {
            ImageLoader.shared.image(with: model.photos[0], folder: "EventPictures"){ result in
                let image = result
                DispatchQueue.main.async {
                    cell.imageEventView.image = image
                }
            }
        }
        cell.delegate = output
        cell.selectionStyle = .none
        return cell
    }
}
extension EventsTodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.clickOnEvent(with: indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? EventsTodayCell else {return nil}
        cell.flipCardAnimation()
        return nil
    }
}

extension EventsTodayViewController {
    internal func addConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.emptyView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20).isActive = true
        self.emptyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
