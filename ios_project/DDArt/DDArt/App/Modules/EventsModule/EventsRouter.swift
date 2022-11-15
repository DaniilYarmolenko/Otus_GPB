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
    func getViews() -> [UIViewController] {
        // Add  Views
        views = [
            EventsTodayContainer.assemble(with: EventsTodayContext()).viewController,
            EventsFutureContainer.assemble(with: EventsFutureContext()).viewController,
            EventsSearchContainer.assemble(with: EventsSearchContext()).viewController
        ]
        return views
    }
}
