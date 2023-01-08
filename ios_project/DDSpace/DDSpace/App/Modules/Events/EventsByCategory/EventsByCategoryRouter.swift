//
//  EventsByCategoryRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import UIKit

final class EventsByCategoryRouter {
    var navigationController: UINavigationController?
}

extension EventsByCategoryRouter: EventsByCategoryRouterInput {
    func eventSelected(event: EventModel) {
        let eventDetail = EventDetailContainer.assemble(with: EventDetailContext(event: event))
        self.navigationController?.pushViewController(eventDetail.viewController, animated: true)
    }
    
}
