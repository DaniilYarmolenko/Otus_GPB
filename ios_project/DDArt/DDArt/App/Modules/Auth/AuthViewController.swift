//
//  AuthViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import UIKit

final class AuthViewController: UIViewController {
	private let output: AuthViewOutput

    init(output: AuthViewOutput) {
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

extension AuthViewController: AuthViewInput {
}
