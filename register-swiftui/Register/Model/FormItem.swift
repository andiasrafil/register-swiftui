//
//  FormItem.swift
//  FormItem
//
//  Created by Accounting on 22/08/21.
//

import Foundation
import UIKit
import SwiftUI


protocol FormItem {
    var id : UUID { get }
    var formId : FormField { get }
    var validations: [ValidationManager] { get }
    var val: Any? { get }
    var error : ValidationError? { get }
}

enum FormField {
    case firstName
    case lastName
    case email
    case submit
    case password
    
}

class FormComponent: FormItem, Identifiable {
    
    
    let id = UUID()
    let formId: FormField
    var validations: [ValidationManager]
    var val: Any?
    var error: ValidationError?
    
    init(_ id: FormField, validations: [ValidationManager] = []) {
        self.formId = id
        self.validations = validations
    }
}

final class TextFormComponent: FormComponent {
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    init(id: FormField, placeholder: String, keyboardType : UIKeyboardType = .default, validations: [ValidationManager] = []) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        super.init(id, validations: validations)
    }
}

final class PasswordFormComponent: FormComponent {
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    init(id: FormField, placeholder: String, keyboardType : UIKeyboardType = .default, validations: [ValidationManager] = []) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        super.init(id, validations: validations)
    }
}

final class ButtonFormComponent: FormComponent {
    let title: String
    init(id: FormField, title: String){
        self.title = title
        super.init(id)
    }
}
