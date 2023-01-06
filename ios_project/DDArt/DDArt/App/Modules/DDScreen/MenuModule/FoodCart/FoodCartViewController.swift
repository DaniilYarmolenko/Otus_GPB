//
//  FoodCartViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class FoodCartViewController: UIViewController {
	private let output: FoodCartViewOutput

    init(output: FoodCartViewOutput) {
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

extension FoodCartViewController: FoodCartViewInput {
}
