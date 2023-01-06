//
//  NewsDetailInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import Foundation

final class NewsDetailInteractor {
	weak var output: NewsDetailInteractorOutput?
}

extension NewsDetailInteractor: NewsDetailInteractorInput {
    func reloadData() {
        
    }
}
