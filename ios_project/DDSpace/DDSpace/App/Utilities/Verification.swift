//
//  Verification.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 02.12.2022.
//

import Foundation

public protocol VerificationProtocol {
    func verify(from plainString: String) -> Bool
}

final class PhoneVerification: VerificationProtocol {
    func verify(from plainString: String) -> Bool {
        guard !plainString.isEmpty else { return false }
        return plainString.validPhoneNumber
    }
}

final class NameVerification: VerificationProtocol {
    func verify(from plainString: String) -> Bool {
        guard plainString.count > 6 else { return false }
        return plainString.validFullName
    }
}

final class EmailVerification: VerificationProtocol {
    func verify(from plainString: String) -> Bool {
        guard !plainString.isEmpty else { return false }
        return plainString.validEmail
    }
}

final class AdressVerification: VerificationProtocol {
    func verify(from plainString: String) -> Bool {
        return plainString.validAdress
    }
}
