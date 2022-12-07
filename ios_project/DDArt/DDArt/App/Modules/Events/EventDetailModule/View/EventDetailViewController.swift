//
//  EventDetailViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.12.2022.
//  
//

import UIKit

final class EventDetailViewController: UIViewController {
	private let output: EventDetailViewOutput

    init(output: EventDetailViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension EventDetailViewController: EventDetailViewInput {
    func reloadData() {
        
    }
    
}
