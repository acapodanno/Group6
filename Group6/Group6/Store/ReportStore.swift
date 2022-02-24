//
//  ReportStore.swift
//  Group6
//
//  Created by Alessandro Capodanno on 24/02/22.
//

import Foundation
class ReportStore: ObservableObject {
    @Published var reportsList: [ReportModel] = ReportApi().getAllReport();
    
    init()
    {
        restoreReportAll()
    }

    func restoreReportAll(){
        reportsList = ReportApi().getAllReport();
    }
    
    func add(report: ReportModel) {
        reportsList.append(report)
    }
}
