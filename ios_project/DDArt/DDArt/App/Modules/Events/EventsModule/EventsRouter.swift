//
//  EventsRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsRouter {
    private var views = [UIViewController]()
}

extension EventsRouter: EventsRouterInput {
    func getViews(allEvent: [EventModel], eventsToday: [EventModel], eventsFuture: [EventModel], category: [CategoryModel], view: EventsViewInput) -> [UIViewController] {
        guard let view = view as? UIViewController, let navigationController = view.navigationController else { return [] }
        views = [
            EventsTodayContainer.assemble(with: EventsTodayContext(eventsToday: eventsToday, navigationController: navigationController)).viewController,
            EventsFutureContainer.assemble(with: EventsFutureContext(eventsFuture: eventsFuture)).viewController,
            EventsSearchContainer.assemble(with: EventsSearchContext(allEvents: allEvent, categories: category)).viewController
        ]
        return views
    }
}
