//
//  PasswordStrengthView.swift
//  PasswordStrengthView
//
//  Created by Accounting on 23/08/21.
//

import SwiftUI

struct PasswordStrengthView: View {
    //@State var strength : PasswordStrength = .none
    @StateObject var viewmodel : RegisterVM
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            HStack(spacing: 5){
                ForEach((1...3), id: \.self){ index in
                    switch viewmodel.passwordError?.strength {
                    case .lemah:
                        if index == 1 {
                            Rectangle()
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, maxHeight: 4)
                        } else {
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, maxHeight: 4)
                        }
                    case .sedang:
                        if index == 3 {
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, maxHeight: 4)
                        } else {
                            Rectangle()
                                .foregroundColor(.orange)
                                .frame(maxWidth: .infinity, maxHeight: 4)
                        }
                    case .kuat:
                        Rectangle()
                            .foregroundColor(.green)
                            .frame(maxWidth: .infinity, maxHeight: 4)
                    case .none:
                        EmptyView()
                    }
                }
            }
        }).transition(.opacity)
        
        
    }
}

//struct PasswordStrengthView_Previews: PreviewProvider {
//    static var previews: some View {
//        PasswordStrengthView(strength: PasswordStrength.sedang)
//    }
//}
