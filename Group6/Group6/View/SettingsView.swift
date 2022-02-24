//
//  SettingsView.swift
//  Group6
//
//  Created by Assunta Della Porta on 19/02/22.
//

import SwiftUI


struct SettingsView: View {
    @State var isPresented : Bool = false

    @Binding var user : User
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Profile image")) {
                    HStack {
                        Spacer()
                        
                        if let image = user.profileImage{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(Color.black, lineWidth: 4))
                            .padding()
                            .onTapGesture {
                                isPresented = true  //quando si clicca sull'immagine si apre lo sheet col picker
                            }
                            
                        }else{
                            
                            Image(uiImage: UIImage(named: "profile image")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 110)
                                .clipShape(Circle())
                                .overlay(Circle()
                                            .stroke(Color.black, lineWidth: 4))
                                .padding()
                                .onTapGesture {
                                    isPresented = true  //quando si clicca sull'immagine si apre lo sheet col picker
                                }
                                

                        }
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
            .sheet(isPresented: $isPresented) {
                //PhotoPicker(profileImage: $user.profileImage?)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var bibbi : User = User(id: 1, isOperator: false, userName: "Francesca", level: 7, points: 102, profileImage: UIImage(named: "profile image")!, reportings: [])
    static var previews: some View {
        SettingsView(user: $bibbi)
    }
}
