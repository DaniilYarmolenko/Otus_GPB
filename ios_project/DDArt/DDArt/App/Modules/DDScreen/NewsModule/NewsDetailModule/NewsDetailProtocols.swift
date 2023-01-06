//
//  NewsDetailProtocols.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

protocol NewsDetailModuleInput {
	var moduleOutput: NewsDetailModuleOutput? { get }
}

protocol NewsDetailModuleOutput: AnyObject {
}

protocol NewsDetailViewInput: AnyObject {
    func loadData(model: NewsModel)
}

protocol NewsDetailViewOutput: AnyObject {
    func viewDidLoad()
    func updateData()
}

protocol NewsDetailInteractorInput: AnyObject {
    func reloadData()
}

protocol NewsDetailInteractorOutput: AnyObject {
    func receiveData(news: NewsModel)
}

protocol NewsDetailRouterInput: AnyObject {
}
