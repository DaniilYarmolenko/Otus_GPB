//
//  NewsDetailPresenter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

final class NewsDetailPresenter {
    weak var view: NewsDetailViewInput?
    weak var moduleOutput: NewsDetailModuleOutput?
    var newsDetail: NewsModel?
    private let router: NewsDetailRouterInput
    private let interactor: NewsDetailInteractorInput
    
    init(router: NewsDetailRouterInput, interactor: NewsDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NewsDetailPresenter: NewsDetailModuleInput {
    var news: NewsModel? {
        get {
            newsDetail
        }
        set {
            newsDetail = newValue
        }
    }
}

extension NewsDetailPresenter: NewsDetailViewOutput {
    func viewDidLoad() {
        if let news = newsDetail {
            receiveData(news: news)
        }
    }
    
    func updateData() {
        interactor.reloadData()
    }
    
}

extension NewsDetailPresenter: NewsDetailInteractorOutput {
    
    func receiveData(news: NewsModel) {
        newsDetail = news
        view?.loadData(model: news)
    }
    
}
