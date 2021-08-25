//
//  ValidationError.swift
//  ValidationError
//
//  Created by Accounting on 23/08/21.
//

import Foundation
import CoreText
import UIKit
import SwiftUI

enum ValidationError : Error {
    case custom(message: String)
    case password(strength: PasswordStrength)
}

extension ValidationError {
    var errorDescription: String {
        switch self {
        case .custom(let message):
            return message
        case .password(strength: let strength):
            switch strength {
            case .lemah:
                return "Diwajibkan berisi minimal 6 karakter dengan kombinasi huruf, angka dan simbol."
            case .sedang:
                return "Gunakan min. 8 karakter kombinasi huruf besar dan kecil, angka, serta simbol untuk meningkatkan keamanan akun."
            case .kuat:
                return ""
            }
        }
    }
    var errorTitle: String? {
        switch self {
        case .custom(_):
            return nil
        case .password(let strength):
            switch strength {
            case .lemah:
                return "Kata sandi lemah."
            case .sedang:
                return "Sedang."
            case .kuat:
                return "Kata sandi kuat."
            }
        }
    }
    
    var strength: PasswordStrength{
        switch self {
        case .custom(_):
            return .lemah
        case .password(let strong):
            return strong
        }
    }
}

enum PasswordStrength {
    case lemah
    case sedang
    case kuat
}

extension PasswordStrength {
    var color: Color {
        switch self{
        case .lemah:
            return .red
        case .sedang:
            return .orange
        case .kuat:
            return .green
        }
        
    }
}

extension PasswordStrength {
    var length: Int{
        switch self{
        case .lemah:
            return 1
        case .sedang:
            return 2
        case .kuat:
            return 3
        }
    }
}
