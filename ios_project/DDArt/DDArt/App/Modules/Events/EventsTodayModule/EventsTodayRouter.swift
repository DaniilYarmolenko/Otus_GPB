//
//  EventsTodayRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsTodayRouter {
}

extension EventsTodayRouter: EventsTodayRouterInput {
    func eventSelected(with view: EventsTodayViewInput?, event: EventModel, navigationController: UINavigationController) {
        print("ZASHLI")
        let eventDetail = EventDetailContainer.assemble(with: EventDetailContext(event: event)) // MARK: Add Eventcontext
        navigationController.pushViewController(eventDetail.viewController, animated: true)
    }
}
