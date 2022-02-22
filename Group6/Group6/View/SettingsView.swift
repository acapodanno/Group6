//
//  SettingsView.swift
//  Group6
//
//  Created by Assunta Della Porta on 19/02/22.
//

import SwiftUI


struct SettingsView: View {
    @Binding var user : User
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Profile image")) {
                    HStack {
                        Spacer()
                        Image(uiImage: user.profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(Color.black, lineWidth: 4))
                            .padding()
                        Spacer()
                    }
                }
                Section(header: Text("User name")) {
                    TextField("nomeUtente", text: $user.userName)
                }
                Section (header: Text("Operator")) {
                    HStack {
                        Toggle("Are you an operator? ", isOn: $user.isOperator)
                    }
                }
            }
            .navigationTitle(Text("Profile Settings"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var bibbi : User = User(isOperator: false, userName: "Francesca", level: 7, points: 102, profileImage: UIImage(named: "profile image")!, reportings: [])
    static var previews: some View {
        SettingsView(user: $bibbi)
    }
}
