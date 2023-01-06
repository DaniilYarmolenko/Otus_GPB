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
    lazy var collectionMenuView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        layout.collectionView?.numberOfItems(inSection: 2)
        layout.itemSize = CGSize(width: SizeConstants.screenWidth/2 - 20, height: SizeConstants.screenHeight/4)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
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
        output.loadData()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "MENU"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: nil, action: #selector(goToCart))
        view.backgroundColor = .white
        setUp()
	}
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraints()
    }
    private func setUp() {
        setUpCollection()
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
    @objc
    func goToCart() {
        
    }
}

extension MenuViewController: MenuViewInput {
    func reloadCollection() {
        collectionMenuView.reloadData()
    }
    
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        output.getCountSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("LOGIC getCountNumberInSection \(output.getCountNumberInSection(section: section))")
        return output.getCountNumberInSection(section: section)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
                 let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.collectionReusableViewIdentifier, for: indexPath) as! SectionHeader
            sectionHeader.label.text = output.getCategoriesName(index: indexPath.section)
            sectionHeader.label.textColor = .black
            print("LOGIC sectionHeader.label.text \(sectionHeader.label.text)")
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
        
        cell.configure(model: output.getCell(section: indexPath.section, index: indexPath.row)) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        print("LOGIC cell \(cell)")
        cell.delegate = output
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.tapOnFood(section: indexPath.section, index: indexPath.row)
    }
}

extension MenuViewController {
    internal func addConstraints() {
        collectionMenuView.translatesAutoresizingMaskIntoConstraints = false
        collectionMenuView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        collectionMenuView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionMenuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionMenuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}


class SectionHeader: UICollectionReusableView {
     var label: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .white
         label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
         label.sizeToFit()
         return label
     }()
    
    static let collectionReusableViewIdentifier = "Header"

     override init(frame: CGRect) {
         super.init(frame: frame)

         addSubview(label)

         label.translatesAutoresizingMaskIntoConstraints = false
         label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
         label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
