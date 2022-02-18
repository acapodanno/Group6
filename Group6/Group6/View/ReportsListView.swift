//
//  ReportListView.swift
//  Utente View
//
//  Created by Costabile Di gregorio on 16/02/22.
//



import SwiftUI

struct ReportListView: View {
    var segnalazione = Report(title: "First Report", location: "Salerno", valid: true, note: "Note varie")
    @State var showingAddView = false
    var body: some View {
        NavigationView{
            List(){
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
        var segnalazione : Report
        var body: some View {
            HStack{
                Image(systemName : "mappin")
                VStack(alignment: .leading, spacing: 2.0){
                    Text(segnalazione.title)
                    Text(segnalazione.location).font(.footnote)
                        .foregroundColor(Color.gray)
                }
            }.frame(height: 60.0)
        }
    }
