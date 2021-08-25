//
//  ValidationManager.swift
//  ValidationManager
//
//  Created by Accounting on 23/08/21.
//

import Foundation
import UIKit

protocol ValidationManager {
    func validate(_ val: Any) -> ValidationError?
}


struct RegexValidationManagerImpl: ValidationManager {
    
    
    private let items: [RegexFormItem]
    
    init(_ items: [RegexFormItem]) {
        self.items = items
    }
    
    func validate(_ val: Any) -> ValidationError? {
        let val = (val as? String) ?? ""
        for regexItems in items {
            let regex = try? NSRegularExpression(pattern: regexItems.pattern)
            let range = NSRange(location: 0, length: val.count)
            if regex?.firstMatch(in: val, options: [], range: range) == nil {
                return regexItems.error
            }
        }
        
        return nil
    }
}

struct PasswordValidationManagerImpl: ValidationManager {
    func validate(_ val: Any) -> ValidationError? {
        var validatePoint = 0
        let val = (val as? String) ?? ""
        let lowerCaseRegex = try? NSRegularExpression(pattern: RegexPatterns.lowerCaseRegex)
        let upperCaseRegex = try? NSRegularExpression(pattern: RegexPatterns.upperCaseRegex)
        let specialCharRegex = try? NSRegularExpression(pattern: RegexPatterns.specialCharRegex)
        let numberRegex = try? NSRegularExpression(pattern: RegexPatterns.numberCaseRegex)
        let range = NSRange(location: 0, length: val.count)
        
        if lowerCaseRegex?.firstMatch(in: val, options: [], range: range) != nil {
            print("lowercase nih tambah 1 point")
            validatePoint += 1
        }
        if upperCaseRegex?.firstMatch(in: val, options: [], range: range) != nil {
            print("uppercase nih tambah 1 point")
            validatePoint += 1
        }
        if specialCharRegex?.firstMatch(in: val, options: [], range: range) != nil {
            print("sepcialchar nih tambah 1 point")
            validatePoint += 1
        }
        if numberRegex?.firstMatch(in: val, options: [], range: range) != nil {
            print("number nih tambah 1 point")
            validatePoint += 1
        }
        
        print("result validatepoint: \(validatePoint) text length: \(val.count)")
        
        if !val.isEmpty {
            if validatePoint >= 2 && validatePoint < 4 && val.count >= 6 {
                return ValidationError.password(strength: .sedang)
            } else if validatePoint == 4 && val.count >= 8 {
                return ValidationError.password(strength: .kuat)
            } else {
                return ValidationError.password(strength: .lemah)
            }
        } else{
            return nil
        }
    }
}
