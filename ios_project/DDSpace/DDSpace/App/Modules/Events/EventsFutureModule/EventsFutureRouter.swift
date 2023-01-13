//
//  EventsFutureRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsFutureRouter {
    weak var navigationController: UINavigationController?
}

extension EventsFutureRouter: EventsFutureRouterInput {
    func eventSelected(event: EventModel) {
        let eventDetail = EventDetailContainer.assemble(with: EventDetailContext(event: event))
        self.navigationController?.pushViewController(eventDetail.viewController, animated: false)
    }
}
