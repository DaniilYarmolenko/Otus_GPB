//
//  EventsSearchViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsSearchViewController: UIViewController {
	private let output: EventsSearchViewOutput

    init(output: EventsSearchViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .blue
	}
}

extension EventsSearchViewController: EventsSearchViewInput {
}
