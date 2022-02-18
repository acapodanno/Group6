//
//  ContentView.swift
//  Group6
//
//  Created by Alessandro Capodanno on 10/02/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ReportListView()
                .tabItem {
                    Image(systemName: "megaphone.fill")
                    Text("Reports")
                }
                UserProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
