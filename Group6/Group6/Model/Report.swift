//
//  seg.swift
//  Segnalazioni View
//
//  Created by Costabile Di gregorio on 16/02/22.
//

import Foundation
struct Report: Identifiable {
    let id = UUID()
    let title : String
    let location : String
    let date = Date()
    var valid : Bool
    var note : String
    
}
