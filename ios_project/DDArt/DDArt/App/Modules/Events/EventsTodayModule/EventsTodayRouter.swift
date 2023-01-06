//
//  EventsTodayRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsTodayRouter {
    var navigationController: UINavigationController?
}

extension EventsTodayRouter: EventsTodayRouterInput {
    func eventSelected(event: EventModel) {
        let eventDetail = EventDetailContainer.assemble(with: EventDetailContext(event: event)) // MARK: Add Eventcontext
        self.navigationController?.pushViewController(eventDetail.viewController, animated: true)
    }
}
