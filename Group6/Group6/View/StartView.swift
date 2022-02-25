//
//  StartView.swift
//  Group6
//
//  Created by Luigi Verolla on 23/02/22.
//

import SwiftUI

struct StartView: View {
    
    @State var operUsername = ""
    @State var operPassword = ""
    @State var operClicked = false
    @State var alertShown = false
    @State var userSelected = false
    
    var body: some View {
        
        let isOperatorValid = Binding(get: {
            return operUsername == "operator" && operPassword == "operator" && operClicked
        }, set: {
            _ in
        })
        
        VStack {
            Text("TrashRadar").font(.title)
            
            Form {
                Section(header: Text("Operator access")) {
                    TextField("Username", text: $operUsername)
                    TextField("Password", text: $operPassword)
                    
                    NavigationLink(isActive: isOperatorValid, destination: {TabNavigationView(reportStore: ReportStore(),couponStore: CouponStore())}) {
                        Button(action: {
                            operClicked = true
                            
                            if(operUsername != "operator" || operPassword != "operator") {
                                alertShown = true
                            }
                        }) {
                            Text("Access as operator")
                        }
                        .alert(isPresented: $alertShown) {
                            Alert(title: Text("Error"), message: Text("Wrong credentials"), dismissButton: .default(Text("Ok")))
                        }
                    }
                }
                Section(footer:
                            NavigationLink(isActive: $userSelected, destination: {TabNavigationView(reportStore: ReportStore(),couponStore: CouponStore())}, label: {
                    Button(action: {
                        userSelected = true
                    }) {
                        Text("Access as standard user")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                })
                ) {
                    EmptyView()
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
