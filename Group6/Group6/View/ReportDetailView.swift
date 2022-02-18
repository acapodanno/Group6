//
//  EditReport.swift
//  Segnalazioni View
//
//  Created by Costabile Di gregorio on 16/02/22.
//

import SwiftUI


struct ReportDetailView: View {
    
    @State var imageArray : [UIImage?] = []
    
    let report : Report
    var body: some View {
            Form{
                Section(header: Text("Location")){
                    HStack{
                        Text(report.location)
                        Spacer()
                        Image(systemName: "mappin")
                    }
                }
                Section(header: Text("Date")){
                    HStack{
                        Text(report.date.formatted())
                        Spacer()
                        Image(systemName: "calendar")
                    }
                }
                Section(header: Text("Photo")){
                    HStack{
                        ScrollView(.horizontal) {
                            ForEach(imageArray, id: \.self) {selectedImage in
                                if selectedImage != nil {
                                    Image(uiImage: selectedImage!)
                                        .resizable()
                                        .frame(width:100, height: 100)
                                } else {
                                    Image(systemName: "rectangle.fill")
                                        .resizable()
                                        .foregroundColor(Color("AccentColor"))
                                        .frame(width: 100, height: 100)
                                }
                            }
                        }
                        
                    }
                }
                Section(header: Text("Note")){
                    HStack{
                        Text(report.note)
                        Spacer()
                        Image(systemName: "note.text")
                    }
                }.navigationTitle(Text("Report Detail"))
        }
    }
}

struct ReportDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReportDetailView(report: Report(title: "Prima Segnalazione", location: "Salerno", valid: true, note: " Note varie"))
    }
}
