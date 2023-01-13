//
//  NewsProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

protocol NewsModuleInput {
    var moduleOutput: NewsModuleOutput? { get }
}

protocol NewsModuleOutput: AnyObject {
}

protocol NewsViewInput: AnyObject {
    func reloadData()
}

protocol NewsViewOutput: AnyObject {
    func viewDidLoad()
    func clickOnNews(with id: Int)
    func getCountNewsCells() -> Int
    func getNewsCell(with index: Int) -> NewsModel
}

protocol NewsInteractorInput: AnyObject {
    func loadNews()
}

protocol NewsInteractorOutput: AnyObject {
    func receiveData(news: [NewsModel])
}

protocol NewsRouterInput: AnyObject {
    func newsSelected(news: NewsModel)
}
