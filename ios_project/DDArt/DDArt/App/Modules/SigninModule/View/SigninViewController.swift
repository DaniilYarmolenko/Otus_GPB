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
    internal var loginTF = CustomTextField()
    internal var password = CustomTextField()
    internal var labelError = UILabel()
    internal var signUpButton = UIButton()
    internal var loginButton = UIButton()
    internal var guessButton = UIButton()
    internal var seePassword = UIButton()
    internal var ddImageView = UIImageView()
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
        setUp()
        view.backgroundColor = .white
	}
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraint()
    }
    func setUp() {
        setUpTextFields()
        setUpErrorLabel()
        setUpLoginButton()
        setUpGuessButton()
        setUpSignUpButton()
        setUpImageView()

    }
    
    func setUpTextFields() {
        view.addSubview(loginTF)
        view.addSubview(password)
        loginTF.delegate = self
        loginTF.isEnabled = true
        loginTF.placeholder = "Login"
        password.delegate = self
        password.isEnabled = true
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.addSubview(seePassword)
        seePassword.addTarget(self, action: #selector(tapSeePaassword), for: .touchUpInside)
    }
    
    func setUpLoginButton() {
        view.addSubview(loginButton)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.setTitleColor(.green, for: .focused)
        loginButton.setBackgroundColor(color: .white, forState: .normal)
        loginButton.setBackgroundColor(color: .purple, forState: .focused)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    func setUpErrorLabel() {
        view.addSubview(labelError)
        labelError.text = "Заполните поля"
        labelError.textColor = .red
        labelError.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 16)
        labelError.isHidden = true
    }
    
    func setUpSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.contentHorizontalAlignment = .trailing
        signUpButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
    }
    func setUpGuessButton() {
        view.addSubview(guessButton)
        guessButton.setTitle("Login as Guess ?", for: .normal)
        guessButton.setTitleColor(.black, for: .normal)
        guessButton.contentHorizontalAlignment = .trailing
        guessButton.addTarget(self, action: #selector(goAsGuess), for: .touchUpInside)
    }
    func setUpImageView() {
        view.addSubview(ddImageView)
        ddImageView.image = UIImage(named: "dd")
    }
    @objc
    func tapSeePaassword() {
        password.isSecureTextEntry.toggle()
    }
    @objc
    func goToSignUp() {
        output.tapOnSignUp()
    }
    @objc
    func goAsGuess() {
        output.tapOnGuess()
    }
    @objc
    func login() {
        if let login = loginTF.text, let password = password.text {
            output.loginUser(login: login, password: password)
        }
    }
    
    
}

extension SigninViewController: SigninViewInput {
    func errorLogin() {
        DispatchQueue.main.async {
            self.labelError.text = "Login or password error"
            self.labelError.isHidden = false
        }
    }
    
}

extension SigninViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField is CustomTextField else { return }
        if textField.text?.isEmpty == false {
            textField.tintColor = .green
            labelError.isHidden = true
            loginButton.isEnabled = true
        } else {
            textField.tintColor = .red
            labelError.isHidden = false
            loginButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
