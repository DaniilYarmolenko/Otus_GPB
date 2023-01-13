//
//  EventsFutureViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsFutureViewController: UIViewController {
    private let output: EventsFutureViewOutput
    internal lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MosaicLayout())
        return collectionView
    }()
    private let refreshControl = UIRefreshControl()
    init(output: EventsFutureViewOutput) {
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
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    private func setUp() {
        setUpcollectionViewBase()
        setUpBase()
        setUpRefreshControll()
    }
    private func setUpBase() {
        self.view.backgroundColor = .white
    }
    
    private func setUpcollectionViewBase() {
        let mosaicLayout = MosaicLayout()
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: mosaicLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EventFutureCell.self, forCellWithReuseIdentifier: EventFutureCell.cellIdentifier)
        view.addSubview(collectionView)
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

extension EventsFutureViewController: EventsFutureViewInput {
    func reloadData() {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
    
}
extension EventsFutureViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.getCountCell()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventFutureCell.cellIdentifier, for: indexPath) as? EventFutureCell else { return UICollectionViewCell() }
        let model = output.getCell(index: indexPath.row)
        cell.configure(model: model) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        if !model.photos.isEmpty {
            ImageLoader.shared.image(with: model.photos[0], folder: "EventPictures"){ result in
                let image = result
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.clickOnEvent(with: indexPath.row)
    }
    
    
}
