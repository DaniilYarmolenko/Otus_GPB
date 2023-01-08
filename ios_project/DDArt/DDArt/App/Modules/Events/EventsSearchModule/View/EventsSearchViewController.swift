//
//  EventsSearchViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsSearchViewController: UIViewController {
	private let output: EventsSearchViewOutput
    internal var searchBar = UISearchBar()
    internal var emptyView =  EmptyView(titleText: "К сожалению такого события нет",subtitleText: "Попробуйте найти другое", imageString: "emptyDB")
    private let refreshControl = UIRefreshControl()
    lazy var collectionCategoriesView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.collectionView?.numberOfItems(inSection: 2)
        layout.itemSize = CGSize(width: SizeConstants.screenWidth/2 - 20, height: SizeConstants.screenHeight/4)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    internal var tableViewEvents = UITableView()
    init(output: EventsSearchViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
	}
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraints()
    }
    private func setUp() {
        setUpTableViewBase()
        setUpCollection()
        setUpSearchBar()
        setUpEmptyView()
    }
    private func setUpTableViewBase() {
        tableViewEvents.showsVerticalScrollIndicator = false
        tableViewEvents.delegate = self
        tableViewEvents.refreshControl = refreshControl
        tableViewEvents.dataSource = self
        tableViewEvents.separatorStyle = .none
        tableViewEvents.isHidden = true
        tableViewEvents.register(EventsSearchTableCell.self, forCellReuseIdentifier: EventsSearchTableCell.cellIdentifier)
        view.addSubview(tableViewEvents)
    }
    private func setUpCollection() {
        collectionCategoriesView.delegate = self
        collectionCategoriesView.dataSource = self
        collectionCategoriesView.backgroundColor = .clear
        collectionCategoriesView.showsHorizontalScrollIndicator = false
        collectionCategoriesView.register(CategoriesSearchCollectionCell.self, forCellWithReuseIdentifier: CategoriesSearchCollectionCell.cellIdentifier)
        self.view.addSubview(collectionCategoriesView)
    }
    private func setUpSearchBar() {
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 10
        searchBar.barTintColor = .white
        searchBar.placeholder = "Введите название или имя автора для поиска"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont(name: FontConstants.MoniqaLightItalicHeading, size: 20)
        view.addSubview(searchBar)
    }
    private func setUpEmptyView() {
        view.addSubview(emptyView)
        emptyView.isHidden = true
    }

    
}

extension EventsSearchViewController: EventsSearchViewInput {
    func reloadTableData() {
        if output.getCountEventCells() == 0 && collectionCategoriesView.isHidden {
            tableViewEvents.isHidden = true
            emptyView.isHidden = false
        } else {
            tableViewEvents.isHidden = false
            emptyView.isHidden = true
        }
        tableViewEvents.reloadData()
    }
    
}
extension EventsSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            collectionCategoriesView.isHidden = true
            tableViewEvents.isHidden = false
        } else {
            collectionCategoriesView.isHidden = false
            tableViewEvents.isHidden = true
        }
        output.searchEventByName(with: searchText.lowercased())
    }
}

extension EventsSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.getCountEventCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsSearchTableCell.cellIdentifier, for: indexPath) as? EventsSearchTableCell else { return UITableViewCell() }
        cell.configure(model: output.getEventCell(with: indexPath.row)) {
            let myCell = tableView.cellForRow(at: indexPath)
            return cell == myCell
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

extension EventsSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.getCountCategoryCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesSearchCollectionCell.cellIdentifier, for: indexPath)
                as? CategoriesSearchCollectionCell else {
                    return UICollectionViewCell()
                }
        
        cell.configure(model: output.getCategoryCell(with: indexPath.row)) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        cell.delegate = output
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            output.clickOnCategory(with: indexPath.row)
    }

    
}


extension EventsSearchViewController {
    internal func addConstraints() {
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        collectionCategoriesView.translatesAutoresizingMaskIntoConstraints = false
        collectionCategoriesView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 10).isActive = true
        collectionCategoriesView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionCategoriesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionCategoriesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        
        tableViewEvents.translatesAutoresizingMaskIntoConstraints = false
        tableViewEvents.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 10).isActive = true
        tableViewEvents.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableViewEvents.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        tableViewEvents.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 10).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
}
