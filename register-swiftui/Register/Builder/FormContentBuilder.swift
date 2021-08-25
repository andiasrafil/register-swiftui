//
//  FormContentBuilder.swift
//  FormContentBuilder
//
//  Created by Accounting on 23/08/21.
//

import Foundation
import Combine

protocol FormContentBuilder {
    var content: [FormComponent] { get }
    func update(_ val: Any, in component: FormComponent)
}

final class FormComponentBuilderImpl: ObservableObject, FormContentBuilder {
    @Published var emailError : ValidationError?
    @Published var firstNameError: ValidationError?
    private(set) var content: [FormComponent] = [
        TextFormComponent(
            id: .firstName,
            placeholder: "Nama Depan*",
            keyboardType: .default,
            validations: [
                RegexValidationManagerImpl(
                    [
                        RegexFormItem(pattern: RegexPatterns.empty, error: .custom(message: "Nama Depan harus diisi.")),
                        //RegexFormItem(pattern: RegexPatterns.nameRegex, error: .custom(message: "Invalid nama depan"))
                    ]
                )
            ]
        ),
        TextFormComponent(
            id: .lastName,
            placeholder: "Nama Belakang"
        ),
        TextFormComponent(
            id: .email,
            placeholder: "Email panjang*",
            keyboardType: .emailAddress,
            validations: [
                RegexValidationManagerImpl(
                    [
                        RegexFormItem(pattern: RegexPatterns.empty, error: .custom(message: "Email harus diisi")),
                        RegexFormItem(pattern: RegexPatterns.emailChars, error: .custom(message: "Masukkan format email yang benar dan valid")),
                        
                    ]
                )
            ]
        ),
        
        PasswordFormComponent(
            id: .password,
            placeholder: "Password",
            validations: [
//                RegexValidationManagerImpl(
//                    [
//                        RegexFormItem(pattern: RegexPatterns.empty, error: .custom(message: "Kata Sandi harus diisi")),
//                    ]
//                ),
                PasswordValidationManagerImpl()
            ]
        ),
        ButtonFormComponent(id: .submit, title: "Confirm")
    ]
    
    func update(_ val: Any, in component: FormComponent) {
        guard let index = content.firstIndex(where: { $0.id == component.id}) else { return }
        content[index].val = val
    }
}
