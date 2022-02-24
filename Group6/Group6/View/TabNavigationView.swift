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
    @Namespace var animation
    @State var currentTab: Tab = .Reports
    var tabBarIcon: TabBarIcon = TabBarIcon()
    // Hiding Tab Bar...
    init(){
        UITabBar.appearance().isHidden = true
    }
    var systemName = "megaphone.fill"
    
    var body: some View {
        
        // binding su tipo notifica
        
        // notifica di tipo "proximity": usata per avvertire l'utente
        // che si trova in un area con segnalazione pendente
        // se arriva tale notifica, la tab selezionata è la 2, cioè la MapView
        var  tabSelection = Binding(get: {
            return $notificationManager.notificationType.wrappedValue == "proximity" ? Tab.Map : Tab.Reports
        }, set: {
            _ in
        })
      VStack{
        TabView(selection: $currentTab) {
            ReportListView()
                .tag(Tab.Reports)
            MapView()
                .tag(Tab.Map)
            StoreView()
                .tag(Tab.Store)
            UserProfileView()
                .tag(Tab.Profile)
        }
        // se l'utente si muove verifichiamo se è vicino ad un'area segnalata (entro un raggio)
        // se si, inviare una notifica
          
          // Custom Tab Bar...
          HStack(spacing: 0){
              ForEach(Tab.allCases,id: \.self){tab in
                  
                  Button {
                       currentTab = tab
                  } label: {
                    
                      Image(systemName: tabBarIcon.getIcon(name: tab.rawValue))
                          .resizable()
                          .renderingMode(.template)
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 22, height: 22)
                          .background(
                          
                              Color("AccentColor")
                                  .opacity(0.1)
                                  .cornerRadius(5)
                                  .blur(radius: 5)
                                  .padding(-7)
                                  .opacity(currentTab == tab ? 1 : 0)
                              
                          )
                          .frame(maxWidth: .infinity)
                          .foregroundColor(currentTab == tab ? Color("AccentColor") : Color.black.opacity(0.3))
                  }
              }
          }
          .padding([.horizontal,.top])
          .padding(.bottom,10)
      }
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

enum Tab: String,CaseIterable{
    
    // Raw Value must be image Name in asset..
    case Reports = "Reports"
    case Map = "Map"
    case Store = "Store"
    case Profile = "Profile"
}
