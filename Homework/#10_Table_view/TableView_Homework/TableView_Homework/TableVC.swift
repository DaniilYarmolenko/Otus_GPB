//
//  TableVC.swift
//  TableView_Homework
//
//  Created by Даниил Ярмоленко on 17.10.2022.
//

import UIKit

class TableVC: UIViewController {
    var dataFromModel: [ModelData] = [ModelData(cityNameLong: "Moscow", countryName: "Russia", description: "The capital and largest city of Russia. The city stands on the Moskva River in Central Russia, with a population estimated at 13.0 million residents within the city limits, over 17 million residents in the urban area, and over 20 million residents in the metropolitan area", photo: "Moscow"), ModelData(cityNameLong: "New York", countryName: "USA", description: "The most populous city in the United States. With a 2020 population of 8,804,190 distributed over 300.46 square miles (778.2 km2), New York City is also the most densely populated major city in the United States. Located at the southern tip of New York State, the city is the center of the New York metropolitan area, the largest metropolitan area in the world by urban landmass.", photo: "NewYork"), ModelData(cityNameLong: "Madrid", countryName: "Spain", description: "The capital and most populous city of Spain. The city has almost 3.4 million inhabitants and a metropolitan area population of approximately 6.7 million. It is the second-largest city in the European Union (EU), and its monocentric metropolitan area is the second-largest in the EU. The municipality covers 604.3 km2 (233.3 sq mi) geographical area")]
}
extension TableVC: UITableViewDelegate {
    
}
extension TableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFromModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .tableId, for: indexPath) as? MainCell else {
            fatalError()
        }
        let data = dataFromModel[indexPath.row]
        cell.nameCityLong.text = data.cityNameLong
        cell.descriptionCity.text = data.description
        cell.countryName.text = data.countryName
        cell.cityImageView.image = UIImage(named: data.photo ?? "noPhoto")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
    }
}
private extension String {
    static let tableId = "TableViewCellReuseID"
}
