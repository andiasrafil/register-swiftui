//
//  RegexPatterns.swift
//  RegexPatterns
//
//  Created by Accounting on 23/08/21.
//

import Foundation

enum RegexPatterns {
    static let empty = "^.$"
    static let emailChars = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let higherThanSixChars = "^.{6,}$"
    static let name = "^[a-zA-Z]+((['][a-zA-Z ])?[a-zA-Z]*)*$"
    static let weakRegex = "^([a-z]|[A-Z]|[^A-Za-z0-9]).{,6}$"
    static let specialCharRegex = "^(?=.*[!@#$&*])"
    static let lowerCaseRegex = "^(?=.*[a-z])"
    static let upperCaseRegex = "^(?=.*[A-Z])"
    static let numberCaseRegex = "^(?=.*[0-9])"
    static let nameRegex = "^[a-zA-Z ’']+$"
}
