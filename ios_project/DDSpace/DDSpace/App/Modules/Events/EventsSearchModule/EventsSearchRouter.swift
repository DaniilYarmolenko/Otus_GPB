//
//  EventsSearchRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsSearchRouter {
    var navigationController: UINavigationController?
}

extension EventsSearchRouter: EventsSearchRouterInput {
    func categorySelected(category: CategoryModel) {
        let categoryEvents = EventsByCategoryContainer.assemble(with: EventsByCategoryContext(category: category, navigationController: navigationController))
        navigationController?.pushViewController(categoryEvents.viewController, animated: false)
    }
    
    func eventSelected(event: EventModel) {
        let eventDetail = EventDetailContainer.assemble(with: EventDetailContext(event: event))
        navigationController?.pushViewController(eventDetail.viewController, animated: false)
    }
    
}
