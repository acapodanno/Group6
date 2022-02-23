//
//  TabNavigationView.swift
//  Group6
//
//  Created by Luigi Verolla on 18/02/22.
//
import SwiftUI
import CoreLocation

struct TabNavigationView: View
{
    // gestore notifiche
    @StateObject var notificationManager = NotificationManager()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        
        // binding su tipo notifica
        
        // notifica di tipo "proximity": usata per avvertire l'utente
        // che si trova in un area con segnalazione pendente
        // se arriva tale notifica, la tab selezionata è la 2, cioè la MapView
        let tabSelection = Binding(get: {
            return $notificationManager.notificationType.wrappedValue == "proximity" ? 2 : 1
        }, set: {
            _ in
        })
      
        TabView(selection: tabSelection) {
            ReportListView()
                .tabItem {
                    Image(systemName: "megaphone.fill")
                    Text("Reports")
                }
                .tag(1)
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
                .tag(2)
            StoreView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Store")
                }
                .tag(3)
            UserProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
        // se l'utente si muove verifichiamo se è vicino ad un'area segnalata (entro un raggio)
        // se si, inviare una notifica
        .onChange(of: locationManager.placeMark) {
            value in
            
            let allReports : [ReportModel] = [] //ReportApi().getAllReport()
            let radius : Double = 100
            for rep in allReports {
                let crds = CLLocationCoordinate2D(latitude: rep.latitude, longitude: rep.longitude)
                let region = CLCircularRegion(center: crds, radius: radius, identifier: "")
                
                if let currCords = locationManager.placeMark?.location?.coordinate {
                    if(region.contains(currCords)) {
                        notificationManager.sendProximityNotification(title: "Report in your area", subtitle: "There is a pending report in your immediate area", body: "", launchIn: 1)
                        
                        break
                    }
                }
            }
        }
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
    }
}
