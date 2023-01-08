//
//  EventsByCategoryViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import UIKit

final class EventsByCategoryViewController: UIViewController {
    private let output: EventsByCategoryViewOutput
    private let refreshControl = UIRefreshControl()
    internal var tableViewEvents = UITableView()
    init(output: EventsByCategoryViewOutput) {
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
        view.backgroundColor = .white
        setUp()
        navigationItem.title = output.getTitle()
        output.viewDidLoad()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraints()
    }
    private func setUp() {
        setUpTableViewBase()
        setUpRefreshContoll()
    }
    private func setUpRefreshContoll() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    private func setUpTableViewBase() {
        tableViewEvents.showsVerticalScrollIndicator = false
        tableViewEvents.delegate = self
        tableViewEvents.refreshControl = refreshControl
        tableViewEvents.dataSource = self
        tableViewEvents.separatorStyle = .none
        tableViewEvents.register(EventsByCategoryCell.self, forCellReuseIdentifier: EventsByCategoryCell.cellIdentifier)
        
        tableViewEvents.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableViewEvents)
    }
    @objc
    func refresh() {
        output.viewDidLoad()
    }
}

extension EventsByCategoryViewController: EventsByCategoryViewInput {
    func reloadData() {
        self.tableViewEvents.reloadData()
        refreshControl.endRefreshing()
    }
    
}
extension EventsByCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getCountEventCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsByCategoryCell.cellIdentifier, for: indexPath) as? EventsByCategoryCell else { return UITableViewCell() }
        let model = output.getEventCell(with: indexPath.row)
        cell.configure(model: model) {
            let myCell = tableView.cellForRow(at: indexPath)
            return cell == myCell
        }
        if !model.photos.isEmpty {
            ImageLoader.shared.image(with: model.photos[0], folder: "EventPictures"){ result in
                let image = result
                DispatchQueue.main.async {
                    cell.eventImage.image = image
                }
            }
        } else {
            cell.eventImage.image = UIImage(named: "ddLarge")
        }
        cell.delegate = output
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SizeConstants.screenHeight/5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.clickOnEvent(with: indexPath.row)
        
    }
}
extension EventsByCategoryViewController {
    internal func addConstraints() {
        tableViewEvents.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableViewEvents.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableViewEvents.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        tableViewEvents.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
}
