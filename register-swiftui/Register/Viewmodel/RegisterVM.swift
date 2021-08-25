//
//  RegisterVM.swift
//  RegisterVM
//
//  Created by Accounting on 23/08/21.
//

import Foundation
import Combine


class RegisterVM : ObservableObject {
    @Published var emailError : ValidationError?
    @Published var firstNameError: ValidationError?
    @Published var passwordError: ValidationError?
    
    func validate(_ content: [FormComponent]) {
        for items in content {
            guard let index = content.firstIndex(where: { $0.id == items.id}) else { return }
            let value = content[index].val as? String ?? ""
            
            if content[index].formId == .email {
                if value.isEmpty {
                    emailError = ValidationError.custom(message: "Email harus diisi")
                }else{
                    emailError = items.validations.compactMap{ $0.validate(value)}.first
                }
            }
            if content[index].formId == .firstName {
                if value.isEmpty {
                    firstNameError = ValidationError.custom(message: "Kata sandi harus diisi.")
                } else {
                    firstNameError = items.validations.compactMap { $0.validate(value) }.first
                }
                firstNameError = items.validations.compactMap{ $0.validate(value)}.first
            }
            if content[index].formId == .password {
                if value.isEmpty {
                    passwordError = ValidationError.custom(message: "Kata sandi harus diisi.")
                } else {
                    passwordError = items.validations.compactMap { $0.validate(value) }.first
                }
            }
        }
        if emailError == nil && firstNameError == nil {
            print("panggil api...")
            ceritanyaAPICALL()
        }
    }
    func ceritanyaAPICALL() {
        emailError = ValidationError.custom(message: "email sudah terdaftar")
    }
    
    func validatePassword(_ component: FormComponent) {
        print("start validating")
        passwordError =  component.validations.compactMap{
            $0.validate(component.val as? String ?? "")
        }.first
        
    }
}
