//
//  EventDetailInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.12.2022.
//  
//

import Foundation

final class EventDetailInteractor {
    weak var output: EventDetailInteractorOutput?
}

extension EventDetailInteractor: EventDetailInteractorInput {
    func reloadData() {
        
    }
    
    func getToken() {
        
    }
    
    func userAuth() -> Bool {
        Auth().token != nil
    }
    
}
