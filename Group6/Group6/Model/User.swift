//
//  User.swift
//  Group6
//
//  Created by Assunta Della Porta on 21/02/22.
//

// Questa struttura contiene tutti i dati relativi ad un utente

import Foundation
import UIKit

struct User : Identifiable {
    var id = UUID()
    var isOperator : Bool  //vero se è un operatore
    var userName : String  //nome utente
    var level : Int  //livello
    var points : Int  //punti accumulati
    var profileImage : UIImage  //immagine di profilo
    var cupons : [Coupon]  //cupon accumulati
    var reportings : [Report]  //report effettuati
    var badges : [Badge]  //badge accumulati
}

