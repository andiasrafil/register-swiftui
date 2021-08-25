//
//  ContentView.swift
//  register-swiftui
//
//  Created by Accounting on 22/08/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentBuilder = FormComponentBuilderImpl()
    @StateObject private var registerVM = RegisterVM()
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 44))], spacing: 20, content: {
                ForEach(contentBuilder.content) { component in
                    switch component{
                    case is TextFormComponent:
                    TextFieldFormView(component: component as! TextFormComponent, registerVM: registerVM)
                            .environmentObject(contentBuilder)
                    case is ButtonFormComponent:
                        Button(action: {
                            print("button Pressed")
                            registerVM.validate(contentBuilder.content)
                        }, label: {
                            Text("nyoba")
                        })
                    case is PasswordFormComponent:
                        PasswordFormView(component: component as! PasswordFormComponent, registerVM: registerVM)
                            .environmentObject(contentBuilder)
                    default:
                        EmptyView()
                    }
                }
            })
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
