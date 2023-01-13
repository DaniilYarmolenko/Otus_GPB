//
//  NewsInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

final class NewsInteractor {
    weak var output: NewsInteractorOutput?
    let newsRequest = ApiService<NewsModel>(resourcePath: "news")
    private var news = [NewsModel]()
    private let group = DispatchGroup()
}

extension NewsInteractor: NewsInteractorInput {
    func loadNews() {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            newsRequest.getAll { newsResult in
                switch newsResult {
                case .failure (_):
                    self.group.leave()
                case .success(let news):
                    self.group.leave()
                    self.news = news
                }
            }
        }
        group.notify(queue: .main, execute: { [self] in
            output?.receiveData(news: news)
        })
    }
    
    
}
