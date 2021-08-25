//
//  TextFieldFormView.swift
//  TextFieldFormView
//
//  Created by Accounting on 22/08/21.
//

import SwiftUI

struct TextFieldFormView: View {
    let component: TextFormComponent
    @State var text = ""
    @State var isTapped = false
    @State var isFocused = false
    @State private var error: ValidationError?
    @EnvironmentObject var contentBuilder: FormComponentBuilderImpl
    @StateObject var registerVM : RegisterVM
    @StateObject var manager = TextFieldManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("",
                      text: $manager.text,onEditingChanged: { (editingChanged) in
                if manager.text == "" {
                    if editingChanged {
                        withAnimation(.easeIn){
                            isTapped = true
                        }
                    } else {
                        withAnimation(.easeOut){
                            isTapped = false
                        }
                    }
                }
                
            },
                      onCommit: {
                if manager.text == "" {
                    withAnimation(.easeOut){
                        isTapped = false
                    }
                }
            }
            )
                .keyboardType(component.keyboardType)
                .padding(.top, isTapped ? 15 : 0)
                .background(
                    Text(component.placeholder)
                        .scaleEffect(isTapped ? 0.714 : 1.0, anchor: .leading)
                        .offset(x: 0, y: isTapped ? -15 : 0)
                        .foregroundColor(isTapped ? .blue : .gray)
                    , alignment: .leading
                )
            
            Rectangle()
                .fill(isTapped ? Color.accentColor : Color.gray)
                .opacity(isTapped ? 1 : 0.5)
                .frame(height: 1)
            
            switch component.formId{
            case .email:
                Text(registerVM.emailError?.errorDescription ?? "")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.red)
                
            case .firstName:
                Text(registerVM.firstNameError?.errorDescription ?? "")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.red)
                
            case .submit, .password, .lastName:
                Text("")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.red)
            }
            
            
        }.onChange(of: manager.text, perform: { value in
            contentBuilder.update(value, in: component)
            print(value)
        })
    }
}
class TextFieldManager: ObservableObject {
    @Published var text = "" {
        didSet {
            let regex = try? NSRegularExpression(pattern: RegexPatterns.nameRegex)
            let range = NSRange(location: 0, length: text.count)
            if !text.isEmpty {
                if regex?.firstMatch(in: text, options: [], range: range) == nil {
                    text = oldValue
                }
            }
        }
    }
}

//extension TextFieldFormView : UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if range.location == 0 && string == " " { // prevent space on first character
//            return false
//        }
//
//        if textField.text?.last == " " && string == " " { // allowed only single space
//            return false
//        }
//
//        if string == " " { return true } // now allowing space between name
//
//        if string.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil {
//            return false
//        }
//
//        return true
//    }
//}
