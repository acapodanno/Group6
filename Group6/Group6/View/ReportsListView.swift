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
    
    @State var segnalazioni:[ReportModel]
    var reportApi:ReportApi = ReportApi()
    @State var showingAddView = false
    @StateObject var locationManager = LocationManager()
    init(){
        self.segnalazioni = reportApi.getAllReport()
    }
    var body: some View {
        NavigationView{
            List(segnalazioni){
                segnalazione in
                NavigationLink(destination: ReportDetailView(report: segnalazione)){
                SegCell(segnalazione: segnalazione)
                }
            }.navigationTitle(Text("Report List"))
            .navigationBarItems(trailing : Button (action: {
                showingAddView.toggle()
            }){
                Image(systemName: "plus.circle").font(.title2)
            })
        }.sheet(isPresented: $showingAddView, onDismiss: {}) {
            AddReportView()
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
            HStack{
                Image(systemName : "mappin")
                VStack(alignment: .leading, spacing: 2.0){
                    Text(segnalazione.description)
                    Text("\(segnalazione.latitude)").font(.footnote)
                        .foregroundColor(Color.gray)
                }
            }.frame(height: 60.0)
        }
    }
