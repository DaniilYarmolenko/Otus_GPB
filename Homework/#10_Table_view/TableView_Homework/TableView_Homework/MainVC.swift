//
//  ViewController.swift
//  TableView_Homework
//
//  Created by Даниил Ярмоленко on 17.10.2022.
//

import UIKit

class MainViewController: TableVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "World City"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupConstaints()
        tableView.register(MainCell.self, forCellReuseIdentifier: .tableId)
        tableView.dataSource = self
        tableView.delegate = self
    }

    func setupConstaints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         ])
    }
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.largeContentTitle = "City"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataFromModel[indexPath.row]
        let vc = DetailVC()
        vc.nameCityLong.text = data.cityNameLong
        vc.cityImageView.image = UIImage(named: data.photo ?? "noPhoto")
        vc.countryName.text = data.countryName
        vc.descriptionCity.text = data.description
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


private extension String {
    static let tableId = "TableViewCellReuseID"
}
