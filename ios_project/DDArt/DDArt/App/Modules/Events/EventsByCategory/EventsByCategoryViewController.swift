//
//  EventsByCategoryViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import UIKit

final class EventsByCategoryViewController: UIViewController {
	private let output: EventsByCategoryViewOutput

    init(output: EventsByCategoryViewOutput) {
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

extension EventsByCategoryViewController: EventsByCategoryViewInput {
    func reloadData() {
//        MARK: Add reload Data
    }
    
}
