//
//  EventsByCategoryInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import Foundation

final class EventsByCategoryInteractor {
	weak var output: EventsByCategoryInteractorOutput?
}

extension EventsByCategoryInteractor: EventsByCategoryInteractorInput {
    func loadEventsByCategory(category: CategoryModel) {
        
    }
}
