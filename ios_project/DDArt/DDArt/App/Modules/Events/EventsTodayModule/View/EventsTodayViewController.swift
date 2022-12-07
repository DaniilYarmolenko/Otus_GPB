//
//  EventsTodayViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsTodayViewController: UIViewController {
	private let output: EventsTodayViewOutput

    init(output: EventsTodayViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .green
	}
}

extension EventsTodayViewController: EventsTodayViewInput {
    func reloadData() {
    }
    
}
