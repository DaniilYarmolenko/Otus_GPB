//
//  DDInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation

final class DDInteractor {
	weak var output: DDInteractorOutput?
    private var newsModel = [NewsModel]()
    private var infoModel = [InfoModel]()
    private var categoryFoodModel = [FoodCategory]()
    let newsRequest = ApiService<NewsModel>(resourcePath: "news")
    let infoRequest = ApiService<InfoModel>(resourcePath: "info")
    let categoryFoodRequest = ApiService<FoodCategory>(resourcePath: "foodCategories")
    private let group = DispatchGroup()
}

extension DDInteractor: DDInteractorInput {
    func loadData() {
//        NotificationCenter.default.post(name: NSNotification.Name("cart"), object: nil)
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            newsRequest.getAll { newsResult in
                switch newsResult {
                case .failure (let error):
                    self.group.leave()
                    print("ERROR \(error)")
                    self.output?.didFail(message: "There was an error getting the news")
                case .success(let news):
                    self.group.leave()
                    self.newsModel = news
                }
            }
        }
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            infoRequest.getAll { infoResult in
                self.group.leave()
                switch infoResult {
                case .failure (let error):
                    print("ERROR \(error)")
                    self.output?.didFail(message: "There was an error getting the info")
                case .success(let info):
                    print(info)
                    self.infoModel = info
                }
            }
        }
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            categoryFoodRequest.getAll { cateegoryFoodResult in
                self.group.leave()
                switch cateegoryFoodResult {
                case .failure (let error):
                    print("ERROR \(error)")
                    self.output?.didFail(message: "There was an error getting the category Food")
                case .success(let category):
                    self.categoryFoodModel = category
                }
            }
        }
        
        group.notify(queue: .main, execute: { [self] in
            output?.receiveData(news: newsModel, categoriesFoods: categoryFoodModel, info: infoModel)
        })
    }
    
    
    func receiveId(with index: Int) -> Int {
        0
    }
    
    func receiveCompilationTitle(with index: Int) -> String {
        ""
    }
    
}
