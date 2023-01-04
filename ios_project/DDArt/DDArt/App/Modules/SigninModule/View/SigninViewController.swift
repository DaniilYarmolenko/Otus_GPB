//
//  SigninViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 26.12.2022.
//  
//

import UIKit

final class SigninViewController: UIViewController {
	private let output: SigninViewOutput

    init(output: SigninViewOutput) {
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

extension SigninViewController: SigninViewInput {
}
