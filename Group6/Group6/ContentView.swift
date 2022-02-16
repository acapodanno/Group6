import SwiftUI

struct ContentView: View
{
    var body: some View
    {
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
            ProfileView()
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
