//
//  NewsPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

final class NewsPresenter {
    weak var view: NewsViewInput?
    weak var moduleOutput: NewsModuleOutput?
    var news = [NewsModel]()
    private let router: NewsRouterInput
    private let interactor: NewsInteractorInput
    
    init(router: NewsRouterInput, interactor: NewsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NewsPresenter: NewsModuleInput {
}

extension NewsPresenter: NewsViewOutput {
    func viewDidLoad() {
        interactor.loadNews()
    }
    
    func clickOnNews(with id: Int) {
        router.newsSelected(news: news[id])
    }
    
    func getCountNewsCells() -> Int {
        news.count
    }
    
    func getNewsCell(with index: Int) -> NewsModel {
        news[index]
    }
    
}

extension NewsPresenter: NewsInteractorOutput {
    func receiveData(news: [NewsModel]) {
        self.news = news
        view?.reloadData()
    }
    
}
