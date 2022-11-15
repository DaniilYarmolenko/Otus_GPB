//
//  CollectionAdapter.swift
//  CollectionViewProject
//
//  Created by Даниил Ярмоленко on 25.10.2022.
//

import UIKit

class CollectionAdapter: NSObject {
    
    var navigationController: UINavigationController?
    
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    var dataFromModel: [ModelData] = [ModelData(cityNameLong: "Moscow", countryName: "Russia", description: "The capital and largest city of Russia. The city stands on the Moskva River in Central Russia, with a population estimated at 13.0 million residents within the city limits, over 17 million residents in the urban area, and over 20 million residents in the metropolitan area", photo: "Moscow"), ModelData(cityNameLong: "New York", countryName: "USA", description: "The most populous city in the United States. With a 2020 population of 8,804,190 distributed over 300.46 square miles (778.2 km2), New York City is also the most densely populated major city in the United States. Located at the southern tip of New York State, the city is the center of the New York metropolitan area, the largest metropolitan area in the world by urban landmass.", photo: "NewYork"), ModelData(cityNameLong: "Madrid", countryName: "Spain", description: "The capital and most populous city of Spain. The city has almost 3.4 million inhabitants and a metropolitan area population of approximately 6.7 million. It is the second-largest city in the European Union (EU), and its monocentric metropolitan area is the second-largest in the EU. The municipality covers 604.3 km2 (233.3 sq mi) geographical area"), ModelData(cityNameLong: "Rome", countryName: "Italy", description: "The capital city of Italy. It is also the capital of the Lazio region, the centre of the Metropolitan City of Rome, and a special comune named Comune di Roma Capitale. With 2,860,009 residents in 1,285 km2 (496.1 sq mi),[2] Rome is the country's most populated comune and the third most populous city in the European Union by population within city limits.", photo: "Rome"), ModelData(cityNameLong: "Los Angeles", countryName: "USA", description: "Often referred to by its initials L.A.,[13] is the commercial, financial, and cultural center of Southern California. With a population of roughly 3.9 million as of 2020,[8] it is also the largest city in the state of California and the second most populous city in the United States after New York City, as well as one of the world's most populous megacities. Los Angeles is known for its Mediterranean climate, ethnic and cultural diversity, Hollywood film industry, and sprawling metropolitan area", photo: "LosAngeles"), ModelData(cityNameLong: "Saint Petersburg", countryName: "Russia", description: "The second-largest city in Russia. It is situated on the Neva River, at the head of the Gulf of Finland on the Baltic Sea, with a population of roughly 5.4 million residents.[9] Saint Petersburg is the fourth-most populous city in Europe after Istanbul, Moscow and London, the most populous city on the Baltic Sea, and the world's northernmost city of more than 1 million residents. As Russia's Imperial capital, and a historically strategic port, it is governed as a federal city.", photo: "SaintPetersburg")]
    
    func setup(for collectionView: UICollectionView){
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: .colId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CollectionAdapter: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataFromModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .colId, for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
        let data = dataFromModel[indexPath.row]
        cell.update(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = dataFromModel[indexPath.row]
        let vc = DetailVC()
        vc.update(data: data)
        navigationController?.pushViewController(vc, animated: true)
    }

    
}
extension String {
    static let colId = "CollectionViewCellReuseID"
}
