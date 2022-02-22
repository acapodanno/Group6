//
//  SettingsView.swift
//  Group6
//
//  Created by Assunta Della Porta on 19/02/22.
//

import SwiftUI


struct SettingsView: View {
    @Binding var nomeUtente : String
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nome utente")) {
                    TextField("nomeUtente", text: $nomeUtente)
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var bibbi : String = "Nome Utente"
    static var previews: some View {
        SettingsView(nomeUtente: $bibbi)
    }
}
