//
//  SignUpInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 05.01.2023.
//  
//

import Foundation

final class SignUpInteractor {
	weak var output: SignUpInteractorOutput?
}

extension SignUpInteractor: SignUpInteractorInput {
    func signUpUser(firstName: String, secondName: String, userName: String, email: String, password: String) {
        let user = CreateUserData(firstName: firstName, lastName: secondName, username: userName, email: email, password: password)
        ApiService<User>(resourcePath: "users/new").save(user) { [weak self] result in
            switch result {
            case .failure:
                self?.output?.errorSignUp()
            case .success:
                self?.output?.successSignUp()
            }
        }
        
    }
}
