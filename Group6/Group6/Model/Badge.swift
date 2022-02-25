//
//  Badge.swift
//  Group6
//
//  Created by Assunta Della Porta on 22/02/22.
//

import Foundation
import UIKit

//struttura contenete tutte informazioni su un badge
struct Badge : Identifiable {
    var id = UUID()
    var name : String
    //TODO: var date : Date = Date()  //data di acquisizione
    var requiredPoints : Int   //punti necesari ad ottenere il badge
    var image : UIImage
}


var badges : [Badge] = [
    Badge(name: "First report", requiredPoints: 1, image: UIImage(named: "Badge1")!),
    Badge(name: "First report resolved", requiredPoints: 1, image: UIImage(named: "Badge3")!),
    Badge(name: "Five reports", requiredPoints: 20, image: UIImage(named: "Badge2")!),
    Badge(name: "Multiple reports", requiredPoints: 1, image: UIImage(named: "Badge4")!)
]
