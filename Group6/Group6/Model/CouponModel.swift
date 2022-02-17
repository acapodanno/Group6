//
//  CouponModel.swift
//  Group6
//
//  Created by Ugo Barbato on 16/02/22.
//

import Foundation

struct Coupon: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let cost: Int
    let acquired: Bool
}
