//
//  EditReport.swift
//  Segnalazioni View
//
//  Created by Costabile Di gregorio on 16/02/22.
//

import SwiftUI


struct ReportDetailView: View {
    
    @State var imageArray : [UIImage?] = []
    @StateObject var lum = LoginPageModel()
    @EnvironmentObject var reportStore : ReportStore
    var report : ReportModel
    
    var loggedUser = UserApi().getUserById(id: UserDefaults.standard.integer(forKey: "userId"))
    
    var body: some View {
        VStack {
            Form{
                Section(header: Text("Location")){
                    HStack{
                        Text("\(report.address)")
                        Spacer()
                        Image(systemName: "mappin")
                    }
                }
                Section(header: Text("Date")){
                    HStack{
                        Text(report.createdAt.formatted())
                        Spacer()
                        Image(systemName: "calendar")
                    }
                }
                Section(header: Text("Photo")){
                    HStack{
                        AsyncImage(
                            url:URL(string:"https://images.unsplash.com/photo-1605600659908-0ef719419d41?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=736&q=80")!,
                            placeholder: { Text("Loading ...") },
                            image: { Image(uiImage: $0).resizable() }
                        )
                            .frame(width: 128, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                    
                    .frame(width: 128, height: 180)
                    
                }
                Section(header: Text("Note")){
                    HStack{
                        Text(report.description)
                        Spacer()
                        Image(systemName: "note.text")
                    }
                }
                
                if loggedUser.isOperator {
                    
                    Section(footer:
                                VStack {
                        Button(action: {
                            ReportApi().updateStatuTakenReport(id: report.id)
                            reportStore.restoreReportAll()
                        }) {
                            Text("Mark as taken")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        Button(action: {
                            ReportApi().updateStatuSolvedReport(id: report.id)
                            reportStore.restoreReportAll()
                        }) {
                            Text("Mark as solved")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle(Text("Report Detail"))
        }
    }
}

struct ReportDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReportDetailView(report: ReportModel(id: 0, description: "", status: "", latitude: 0, longitude: 0, createdAt: Date.now, address: ""))
    }
}
