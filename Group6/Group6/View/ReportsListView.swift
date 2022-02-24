//
//  ReportListView.swift
//  Utente View
//
//  Created by Costabile Di gregorio on 16/02/22.
//



import SwiftUI
import CoreLocation
import AVFAudio

struct ReportListView: View {
    
    var reportApi:ReportApi = ReportApi()
    @State var showingAddView = false
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var reportStore:ReportStore
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                        // Displaying Products...
                        VStack(spacing: 15){
                            
                            ForEach (reportStore.reportsList){
                                segnalazione in
                                NavigationLink(destination: ReportDetailView(report: segnalazione)){
                                SegCell(segnalazione: segnalazione)
                                }
                        }
                        .padding(.top,25)
                        .padding(.horizontal)
           
            }.navigationTitle(Text("Report List"))
            .navigationBarItems(trailing : Button (action: {
                showingAddView.toggle()
            }){
                Image(systemName: "plus.circle").font(.title2)
            })}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: $showingAddView, onDismiss: {}) {
            AddReportView().environmentObject(reportStore)
        }
    }
}
    struct ReportListView_Previews: PreviewProvider {
        static var previews: some View {
            ReportListView()
        }
        
    }
    
    struct SegCell : View {
        var segnalazione : ReportModel
        let location = CLLocation(latitude: -22.963451, longitude: -43.198242)
        var body: some View {
            HStack(spacing: 15){
                        VStack(alignment: .leading, spacing: 8) {
                            HStack{
                                Image(systemName : "mappin").foregroundColor(.white)
                            Text("Report n°\(segnalazione.id)")
                                .font(.custom(customFont, size: 18).bold())
                                .lineLimit(1)
                                .foregroundColor(Color(.white))
                            }
                            Text(segnalazione.address)
                                .font(.custom(customFont, size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.white))
                            
                            Text("\(segnalazione.createdAt.formatted())")
                                .font(.custom(customFont, size: 13))
                                .foregroundColor(Color(.white))
                        }
                    }
                    .padding(.horizontal,10)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background(
                    
                        Color("AccentColor")
                    )
                    .cornerRadius(10)
        }
    }
