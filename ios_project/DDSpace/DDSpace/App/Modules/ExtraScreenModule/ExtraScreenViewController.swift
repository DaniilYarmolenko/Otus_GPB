//
//  ExtraScreenViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 02.11.2022.
//  
//

import UIKit

final class ExtraScreenViewController: UIViewController {
	private let output: ExtraScreenViewOutput
    internal var sorryLabel = UILabel()
    internal var buttonAuth = UIButton()
    init(output: ExtraScreenViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setUp()
	}
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    private func setUp() {
        setUpLabel()
        setUpButton()
    }
    private func setUpLabel() {
        sorryLabel.text = "На этой странице будет информация о пользователе, основные настройки и самое главное - список мероприятий, на которые пользователь зарегистрировался (с QR кодами). Не успел реализовать, простите :("
        sorryLabel.textColor = .black
        sorryLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 30)
        sorryLabel.numberOfLines = 0
        view.addSubview(sorryLabel)
    }
    private func setUpButton() {
        buttonAuth.titleLabel?.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 30)
        buttonAuth.setTitleColor(.black, for: .normal)
        view.addSubview(buttonAuth)
        if Auth().token == nil {
            buttonAuth.setTitle("Войти ?", for: .normal)
            buttonAuth.addTarget(self, action: #selector(touchLoginButton), for: .touchUpInside)
        } else {
            buttonAuth.setTitle("Выйти", for: .normal)
            buttonAuth.addTarget(self, action: #selector(touchLogoutButton), for: .touchUpInside)
        }
    }
    @objc
    func touchLogoutButton() {
        output.touchLogoutButton()
    }
    @objc
    func touchLoginButton() {
        output.touchLoginButton()
    }
    private func addConstraints() {
        sorryLabel.translatesAutoresizingMaskIntoConstraints = false
        sorryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sorryLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sorryLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth - 100).isActive = true
        sorryLabel.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/2).isActive = true
        
        buttonAuth.translatesAutoresizingMaskIntoConstraints = false
        buttonAuth.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonAuth.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        buttonAuth.widthAnchor.constraint(equalToConstant: SizeConstants.screenWidth - 100).isActive = true
        buttonAuth.heightAnchor.constraint(equalToConstant: SizeConstants.screenHeight/10).isActive = true
    }
}

extension ExtraScreenViewController: ExtraScreenViewInput {
}
