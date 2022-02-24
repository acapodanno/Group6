//
//  TabBarIcon.swift
//  Group6
//
//  Created by Alessandro Capodanno on 24/02/22.
//

import Foundation

class TabBarIcon{
    func getIcon(name:String)->String{
        var systemName:String=""
        if name=="Reports"{
            systemName="megaphone.fill"
        }else if name=="Map" {
            systemName = "map.fill"
        }else if name=="Store" {
            systemName="cart.fill"
        }else if name=="Profile" {
            systemName="person.fill"
        }
        return systemName
    }
}
