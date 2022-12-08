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
}

extension DDInteractor: DDInteractorInput {
    func loadData() {
        output?.receiveData(news: [NewsModel(titleNews: "aaa", newsName: "ИИИ", description: "фвыфвф", photos: []), NewsModel(titleNews: "aaa", newsName: "ИИИ", description: "фвыфвф", photos: []), NewsModel(titleNews: "aaa", newsName: "ИИИ", description: "фвыфвф", photos: []), NewsModel(titleNews: "aaa", newsName: "ИИИ", description: "фвыфвф", photos: [])], categoriesFoods: [FoodCategory(name: "nadsnsda", photos: []), FoodCategory(name: "nadsnsda", photos: []), FoodCategory(name: "nadsnsda", photos: []), FoodCategory(name: "nadsnsda", photos: []), FoodCategory(name: "nadsnsda", photos: [])], info: [InfoModel(phoneNumber: "+79162804297", email: "dsadadsa", address: "Moscow, Tverskaya str 1", longitude: "adasdadsa", latitude: "sdaasdaads")])
    }
    
    func receiveId(with index: Int) -> Int {
        0
    }
    
    func receiveCompilationTitle(with index: Int) -> String {
        ""
    }
    
}
