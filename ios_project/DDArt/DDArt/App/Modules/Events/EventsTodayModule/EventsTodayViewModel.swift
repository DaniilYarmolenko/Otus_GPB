//
//  EventsTodayViewModel.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 11.12.2022.
//

import Foundation
final class EventsTodayViewModel: CellIdentifiable {
    var cellHeight: Float {
        return Float(SizeConstants.screenHeight/2)
    }
    
    var output: EventsTodayViewOutput
    
    typealias ActionHandler = (Int) -> Void
    var action: ActionHandler?

    var cellIdentifier: String {
        return EventsTodayCell.cellIdentifier
    }

    var eventModel: [EventModel]

    init(model: [EventModel], action: ActionHandler? = nil, output: EventsTodayViewOutput) {
        self.eventModel = model
        self.action = action
        self.output = output
    }
}
