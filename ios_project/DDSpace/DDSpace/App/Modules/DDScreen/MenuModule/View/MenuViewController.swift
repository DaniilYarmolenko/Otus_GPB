//
//  MenuViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//  
//

import UIKit

final class MenuViewController: UIViewController {
    private let output: MenuViewOutput
    var scrollSection: Int?
    lazy var collectionCategoryView: CategoryCollectionAdapter = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: SizeConstants.screenWidth/4, height: SizeConstants.screenHeight/20)
        return CategoryCollectionAdapter(frame: .zero, collectionViewLayout: layout, output: output)
    }()
    lazy var collectionMenuView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        //        layout.collectionView?.numberOfItems(inSection: 2)
        layout.itemSize = CGSize(width: SizeConstants.screenWidth/2 - 20, height: SizeConstants.screenHeight/4)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    let btn = BadgedButtonItem(with: UIImage(named: "cart"))
    init(output: MenuViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartBadge), name: NSNotification.Name("cartBadge"), object: nil)
        output.loadData()
        view.backgroundColor = .white
        setUp()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraints()
    }
    private func setUp() {
        setUpNavigation()
        setUpCollection()
        setUpCollectionCategory()
        
    }
    private func scrollToSection() {
        if let section = scrollSection {
            let scrollableSection = IndexPath.init(row: 0, section: section)
            collectionMenuView.scrollToItem(at: scrollableSection, at: .top, animated: true)
        }
    }
    private func setUpCollectionCategory() {
        collectionCategoryView.backgroundColor = .clear
        collectionCategoryView.setup(for: collectionCategoryView)
        self.view.addSubview(collectionCategoryView)
        
    }
    private func setUpCollection() {
        collectionMenuView.delegate = self
        collectionMenuView.dataSource = self
        collectionMenuView.backgroundColor = .clear
        collectionMenuView.showsHorizontalScrollIndicator = false
        collectionMenuView.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.cellIdentifier)
        collectionMenuView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.collectionReusableViewIdentifier)
        self.view.addSubview(collectionMenuView)
    }
    private func setUpNavigation() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "MENU"
        navigationItem.rightBarButtonItem = btn
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont(name: FontConstants.MoniqaMediumNarrow, size: 32)!, NSAttributedString.Key.baselineOffset: -2]
        btn.tapAction = {
            self.output.goToCart()
        }
    }
    @objc
    func goToCart() {
        
    }
    @objc
    func cartBadge() {
        UserDefaults.standard.set(output.countCart(), forKey: "countCart")
        self.btn.setBadge(with: UserDefaults.standard.integer(forKey: "countCart"))
    }
}

extension MenuViewController: MenuViewInput {
    func goToCategory(section: Int) {
        let scrollableSection = IndexPath.init(row: 0, section: section)
        collectionMenuView.scrollToItem(at: scrollableSection, at: .top, animated: true)
    }
    
    func reloadCollection() {
        collectionMenuView.reloadData()
        collectionCategoryView.reloadData()
        scrollToSection()
    }
    
}


extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        output.getCountSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.getCountNumberInSection(section: section)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.collectionReusableViewIdentifier, for: indexPath) as! SectionHeader
            sectionHeader.label.text = output.getCategoriesName(index: indexPath.section)
            sectionHeader.label.textColor = .black
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCell.cellIdentifier, for: indexPath)
                as? FoodCell else {
            return UICollectionViewCell()
        }
        let model = output.getCell(section: indexPath.section, index: indexPath.row)
        cell.configure(model: model) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        if !model.photos.isEmpty {
        ImageLoader.shared.image(with: model.photos[0], folder: "FoodPictures"){ result in
                    let image = result
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
        } else {
            cell.imageView.image = UIImage(named: "ddLarge")
        }
        cell.delegate = output
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.tapOnFood(section: indexPath.section, index: indexPath.row)
    }
}

extension MenuViewController {
    internal func addConstraints() {
        
        collectionCategoryView.translatesAutoresizingMaskIntoConstraints = false
        collectionCategoryView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionCategoryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        collectionCategoryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionCategoryView.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/20).isActive = true
        collectionMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionMenuView.topAnchor.constraint(equalTo: self.collectionCategoryView.bottomAnchor, constant:    10).isActive = true
        collectionMenuView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionMenuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionMenuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}


class SectionHeader: UICollectionReusableView {
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 30)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    static let collectionReusableViewIdentifier = "Header"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CategoryCollectionAdapter: UICollectionView {
    let output: MenuViewOutput
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, output: MenuViewOutput) {
        self.output = output
        super.init(frame: frame, collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCollectionAdapter: UICollectionViewDataSource, UICollectionViewDelegate {
    func setup(for collectionView: UICollectionView){
        collectionView.register(CategoryFoodMenuCell.self, forCellWithReuseIdentifier: CategoryFoodMenuCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            output.getCountSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryFoodMenuCell.cellIdentifier, for: indexPath)
                as? CategoryFoodMenuCell else { return UICollectionViewCell()}
        cell.configure(name: output.getCategoriesName(index: indexPath.row) ) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: SizeConstants.screenHeight/7)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.selectCategory(index: indexPath.row)
    }
}
