//
//  NewsCollectionTableViewCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import UIKit

final class NewsCollectionTableViewCell: BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var array: [NewsModel] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: SizeConstants.screenWidth - 40, height: SizeConstants.screenHeight/4-5)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
//    collectionView.scrollToItem(at: , at: .center, animated: false)
    static let cellIdentifier = String(describing: NewsCollectionTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [collectionView].forEach { [weak self] in
            self?.contentView.addSubview($0)
        }
        addConstraintsCollectionView()
        setUp()
    }
    
    override func updateViews() {
        guard let model = model as? NewsCollectionViewModel else { return }
        array = model.array
        collectionView.reloadData()
    }
    
    private func setUp() {
        backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(NewsCollectionCell.self, forCellWithReuseIdentifier: NewsCollectionCell.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionCell.cellIdentifier, for: indexPath)
                as? NewsCollectionCell else {
                    return UICollectionViewCell()
                }
        
        cell.configure(model: array[indexPath.row]) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        if !array[indexPath.row].photos.isEmpty {
        ImageLoader.shared.image(with: array[indexPath.row].photos[0], folder: "NewsPictures"){ result in
                    let image = result
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
        } else {
            cell.imageView.image = UIImage(named: "ddLarge")
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = model as? NewsCollectionViewModel else { return }
        model.action?(indexPath.row)
    }

}
