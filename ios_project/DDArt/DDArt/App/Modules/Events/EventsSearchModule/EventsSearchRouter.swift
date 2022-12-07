//
//  EventsSearchRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsSearchRouter {
}

extension EventsSearchRouter: EventsSearchRouterInput {
    func categorySelected(with view: EventsSearchViewInput?, and category: CategoryModel) {
        guard let view = view as? UIViewController else { return }
        let categoryEvents = EventsByCategoryContainer.assemble(with: EventsByCategoryContext(category: category)) // MARK: Add Eventcontext
        view.navigationController?.pushViewController(categoryEvents.viewController, animated: true)
    }
    
    func eventSelected(with view: EventsSearchViewInput?, and event: EventModel) {
        guard let view = view as? UIViewController else { return }
        let eventDetail = EventDetailContainer.assemble(with: EventDetailContext(event: event)) // MARK: Add Eventcontext
        view.navigationController?.pushViewController(eventDetail.viewController, animated: true)
    }
    
}
