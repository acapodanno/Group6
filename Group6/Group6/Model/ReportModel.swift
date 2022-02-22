//
//  ReportModel.swift
//  Group6
//
//  Created by Alessandro Capodanno on 21/02/22.
//

import Foundation

struct ReportModel:Identifiable{
    let id: Int32
    let description:String
    let status:String
    let latitude:Double
    let longitude:Double
    let createdAt:Date
    let address:String
}
