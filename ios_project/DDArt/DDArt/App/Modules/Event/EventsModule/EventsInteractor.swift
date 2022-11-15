//
//  EventsInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import Foundation


final class EventsInteractor {
	weak var output: EventsInteractorOutput?
}

extension EventsInteractor: EventsInteractorInput {
    func getData() {
        
    }
    
    
    func getData(index: Int){
        var model: String = ""
        switch index {
        case 0:
            model = "TODAY"
        case 1:
            model = "Future"
        case 2:
            model = "Search"
        default:
            model = "UNKNOWN"
        }
        output?.receiveViewSegment(model: model, index: index)
    }
    

    
}
