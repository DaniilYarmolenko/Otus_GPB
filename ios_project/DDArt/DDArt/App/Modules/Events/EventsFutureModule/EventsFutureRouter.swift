//
//  EventsFutureRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsFutureRouter {
}

extension EventsFutureRouter: EventsFutureRouterInput {
    func eventSelected(with view: EventsFutureViewInput?, and event: EventModel) {
        guard let view = view as? UIViewController else { return }
        let eventDetail = EventDetailContainer.assemble(with: EventDetailContext(event: event)) // MARK: Add Eventcontext
        view.navigationController?.pushViewController(eventDetail.viewController, animated: true)
    }
}
