//
//  ColorDetailViewController.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import UIKit

final class ColorDetailViewController: UIViewController {
	private let output: ColorDetailViewOutput
    internal lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MosaicLayout())
        return collectionView
    }()
    init(output: ColorDetailViewOutput) {
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
    private func setUp() {
        setUpBase()
        setUpcollectionViewBase()
    }
    private func setUpBase() {
        self.view.backgroundColor = .lightGray
        self.navigationController?.navigationBar.topItem?.title = "Colors"
        self.navigationItem.title = "red"
    }
    
    private func setUpcollectionViewBase() {
        let mosaicLayout = MosaicLayout()
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: mosaicLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.indicatorStyle = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailColorCell.self, forCellWithReuseIdentifier: DetailColorCell.cellIdentifier)
        view.addSubview(collectionView)
    }
}
extension ColorDetailViewController: UICollectionViewDelegateFlowLayout {
}
extension ColorDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.getCellsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: output.getCellIdentifier(at: indexPath.row), for: indexPath) as? DetailColorCell else { return UICollectionViewCell() }
        cell.configure(model: output.getCell(at: indexPath.row)) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.openFullScreen(index: indexPath.row)
    }
    
    
}
extension ColorDetailViewController: ColorDetailViewInput {
    func reloadData() {
        collectionView.reloadData()
    }
    
}
