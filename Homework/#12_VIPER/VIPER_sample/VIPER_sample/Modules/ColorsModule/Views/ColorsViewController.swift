//
//  ColorsViewController.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import UIKit

final class ColorsViewController: UIViewController {
	private let output: ColorsViewOutput

    internal lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ColumnFlowLayout())
        return collectionView
    }()
    
    init(output: ColorsViewOutput) {
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraintsCollectionView()
    }
    private func setUp() {
        setUpBase()
        setUpcollectionViewBase()
    }
    private func setUpBase() {
        self.view.backgroundColor = .lightGray
        self.navigationController?.navigationBar.topItem?.title = "Colors"
    }
    
    private func setUpcollectionViewBase() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.cellIdentifier)
    }
}
extension ColorsViewController: UICollectionViewDelegateFlowLayout {
}
extension ColorsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.getCellsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: output.getCellIdentifier(at: indexPath.row), for: indexPath) as? ColorCell else { return UICollectionViewCell() }
        cell.configure(model: output.getCell(at: indexPath.row)) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.itemSelected(index: indexPath.row)
    }
    
    
}
extension ColorsViewController: ColorsViewInput {
    func reloadData() {
        collectionView.reloadData()
    }
    
}
