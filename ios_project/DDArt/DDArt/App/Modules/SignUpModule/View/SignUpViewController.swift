//
//  SignUpViewController.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.01.2023.
//  
//

import UIKit

final class SignUpViewController: UIViewController {
    private let output: SignUpViewOutput
    //    internal var firsNameTF = CustomTextField()
    //    internal var lastNameTF = CustomTextField()
    //    internal var userNameTF = CustomTextField()
    //    internal var emailTF = CustomTextField()
    //    internal var passwordTF = CustomTextField()
    //    internal var confirmPassword = CustomTextField()
    internal var stack = UIStackView()
    internal var dismissButton = UIButton()
    internal var scroll = UIScrollView()
    internal var signUpButton = UIButton()
    var id = 1
    
    init(output: SignUpViewOutput) {
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
        setUp()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addContraints()
    }
    private func setUp() {
        for cellNames in ["First Name", "Second Name", "Login Name", "Email", "Password", "Confirm password"]{
            createTableCell(cellNames)
        }
        setupTable()
        setupSignUpButtom()
        setUpDismissButon()
    }
    private func setupSignUpButtom(){
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.layer.cornerRadius = 50
        signUpButton.addTarget(self, action: #selector(clickSignUp), for: .touchUpInside)
        signUpButton.backgroundColor = .blue
        signUpButton.layer.cornerRadius = 20
        signUpButton.isEnabled = false
        self.view.addSubview(signUpButton)
    }
    private func setUpDismissButon() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.setImage(UIImage(named: "dismiss"),for: .normal)
        dismissButton.addTarget(self, action: #selector(clickOnDismiss), for: .touchUpInside)
        self.view.addSubview(dismissButton)
    }
    private func setupTable() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        scroll.addSubview(stack)
        self.view.addSubview(scroll)
    }
    
    private func createCellLabelView(_ text: String) -> UILabel{
        
        let cellLabelView = UILabel()
        cellLabelView.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        cellLabelView.textColor = .darkGray
        cellLabelView.text = text
        cellLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        return cellLabelView
    }
    
    private func createTextField(_ placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.delegate = self
        textField.isEnabled = true
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        if id > 4 {
            textField.isSecureTextEntry = true
        }
        textField.tag = id
        id += 1
        return textField
    }
    
    private func createLine() -> UIView{
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([line.heightAnchor.constraint(equalToConstant: 0.5)])
        
        return line
    }
    
    private func createSpacing() -> UIView {
        let line = UIView()
        line.backgroundColor = .white
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([line.heightAnchor.constraint(equalToConstant: 24)])
        
        return line
    }
    
    private func createTableCell(_ text: String) {
        self.stack.addArrangedSubview(createCellLabelView(text))
        self.stack.addArrangedSubview(createTextField(text))
        self.stack.addArrangedSubview(createLine())
        self.stack.addArrangedSubview(createSpacing())
    }
    @objc
    func clickOnDismiss() {
        output.dismiss()
    }
    @objc
    func clickSignUp() {
        guard let firsNameTF = stack.viewWithTag(1) as? UITextField else {return}
        guard let secondNameTF = stack.viewWithTag(2) as? UITextField else {return}
        guard let userNameTF = stack.viewWithTag(3) as? UITextField else {return}
        guard let emailTF = stack.viewWithTag(4) as? UITextField else {return}
        guard let passwordTF = stack.viewWithTag(5) as? UITextField else {return}
        guard let confirmTF = stack.viewWithTag(6) as? UITextField else {return}
        if let firstName = firsNameTF.text, let secondName = secondNameTF.text, let userName = userNameTF.text, let email = emailTF.text, let password = passwordTF.text, let confirm = confirmTF.text {
            if password == confirm {
                output.signUp(firstName: firstName, secondName: secondName, userName: userName, email: email, password: password)
            } else {
                output.noConfirm()
            }
        }
        
    }
}

extension SignUpViewController: SignUpViewInput {
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == false {
            textField.tintColor = .green
//            labelError.isHidden = true
            signUpButton.isEnabled = true
        } else {
            textField.tintColor = .red
//            labelError.isHidden = false
            signUpButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
