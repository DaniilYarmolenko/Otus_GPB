//
//  EventsByCategoryRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import UIKit

final class EventsByCategoryRouter {
}

extension EventsByCategoryRouter: EventsByCategoryRouterInput {
    func eventSelected(with view: EventsByCategoryViewInput?, and event: EventModel) {
        guard let view = view as? UIViewController else { return }
        let eventDetail = EventDetailContainer.assemble(with: EventDetailContext(event: event)) // MARK: Add Eventcontext
        view.navigationController?.pushViewController(eventDetail.viewController, animated: true)
    }
    
}
