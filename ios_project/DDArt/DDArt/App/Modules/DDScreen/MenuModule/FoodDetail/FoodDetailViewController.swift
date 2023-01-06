//
//  FoodDetailViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class FoodDetailViewController: UIViewController {
	private let output: FoodDetailViewOutput

    init(output: FoodDetailViewOutput) {
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

extension FoodDetailViewController: FoodDetailViewInput {
}
