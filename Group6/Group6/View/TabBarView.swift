//
//  TabBarView.swift
//  Group6
//
//  Created by Assunta Della Porta on 19/02/22.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ReportListView()
                .tabItem {
                    Image(systemName: "megaphone.fill")
                    Text("Reports")
                }
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            StoreView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Store")
                }
            UserProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}


struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
