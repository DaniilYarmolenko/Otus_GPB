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
    print("LOAD 1")
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            newsRequest.getAll { newsResult in
                print("LOAD 2")
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
            print("LOAD 2")
            output?.receiveData(news: news)
        })
    }
    
    
}
