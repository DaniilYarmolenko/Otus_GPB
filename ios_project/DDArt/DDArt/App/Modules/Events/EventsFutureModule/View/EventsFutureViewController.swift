//
//  EventsFutureViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class EventsFutureViewController: UIViewController {
	private let output: EventsFutureViewOutput

    init(output: EventsFutureViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .yellow
	}
}

extension EventsFutureViewController: EventsFutureViewInput {
    func reloadData() {
//        MARK: Reload Data
    }
    
}
