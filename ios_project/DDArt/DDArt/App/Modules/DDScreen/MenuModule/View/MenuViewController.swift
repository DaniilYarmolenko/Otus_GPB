//
//  MenuViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 09.12.2022.
//  
//

import UIKit

final class MenuViewController: UIViewController {
	private let output: MenuViewOutput

    init(output: MenuViewOutput) {
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

extension MenuViewController: MenuViewInput {
}
