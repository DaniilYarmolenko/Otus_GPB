//
//  AuthInteractor.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.12.2022.
//  
//

import Foundation

final class AuthInteractor {
	weak var output: AuthInteractorOutput?
}

extension AuthInteractor: AuthInteractorInput {
}
