//
//  PasswordFormView.swift
//  PasswordFormView
//
//  Created by Accounting on 23/08/21.
//

import SwiftUI
import UIKit

struct PasswordFormView: View {
    let component: PasswordFormComponent
    @State var text = ""
    @State var isTapped = false
    @State var isFocused = false
    @State var isRevealed = false
    @EnvironmentObject var contentBuilder: FormComponentBuilderImpl
    @StateObject var registerVM : RegisterVM
    var color : Color = .blue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack(alignment: .bottom){
                MyTextField(text: $text, isRevealed: $isRevealed, isFocused: $isFocused)
                    .font(.system(size: 14))
                    .padding(.top, isFocused ? 15 : 0)
                    .background(
                        Text(component.placeholder)
                            .scaleEffect(isFocused ? 0.714 : 1.0, anchor: .leading)
                            .offset(x: 0, y: isFocused ? -15 : 0)
                            .foregroundColor(registerVM.passwordError != nil && registerVM.passwordError?.strength == .lemah && !text.isEmpty ? .red : isFocused ? .blue : .gray)
                        , alignment: .leading
                    )
                
                Button(action: {
                                self.isRevealed.toggle()
                            }) {
                                Image(systemName: self.isRevealed ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.blue)
                            }
            }
            Rectangle()
                .fill(registerVM.passwordError != nil && registerVM.passwordError?.strength == .lemah ? .red : .gray)
                .opacity(registerVM.passwordError != nil ? 1 : 0.5)
                .frame(height: 1)
            
            
            if !text.isEmpty{
                PasswordStrengthView(viewmodel: registerVM)
            }
//            else {
//                Text("Diwajibkan berisi minimal 6 karakter dengan kombinasi huruf, angka dan simbol")
//                    .foregroundColor(isFocused ? .blue : .gray)
//            }
            
            if registerVM.passwordError != nil {
                Text(registerVM.passwordError?.errorTitle ?? "")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(registerVM.passwordError?.strength.color)
                + Text(registerVM.passwordError?.errorDescription ?? "")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(registerVM.passwordError?.strength.color)
            } else {
                Text("Diwajibkan berisi minimal 6 karakter dengan kombinasi huruf, angka dan simbol.")
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(isFocused ? .blue : .gray)
                    .font(.system(size: 12, weight: .regular))
            }
            
            
            
        }.onChange(of: text, perform: { value in
                contentBuilder.update(value, in: component)
                registerVM.validatePassword(component)
        })
    }
}


struct MyTextField: UIViewRepresentable {

    // 1
    @Binding var text: String
    @Binding var isRevealed: Bool
    @Binding var isFocused: Bool

     // 2
    func makeUIView(context: UIViewRepresentableContext<MyTextField>) -> UITextField {
        let tf = UITextField(frame: .zero)
        tf.isUserInteractionEnabled = true
        tf.delegate = context.coordinator
        return tf
    }

    func makeCoordinator() -> MyTextField.Coordinator {
        return Coordinator(text: $text, isFocused: $isFocused)
    }

    // 3
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.isSecureTextEntry = !isRevealed
    }

    // 4
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isFocused: Bool

        init(text: Binding<String>, isFocused: Binding<Bool>) {
            _text = text
            _isFocused = isFocused
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        ;
        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                withAnimation(.easeIn){
                    self.isFocused = true
                }
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                withAnimation(.easeOut){
                    self.isFocused = false
                }
            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }
    }
}
