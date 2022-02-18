//
//  CouponStore.swift
//  Group6
//
//  Created by Ugo Barbato on 16/02/22.
//

import Foundation

class CouponStore: ObservableObject {
    @Published var allCoupons = [Coupon]()
    
    init() {
        let coupon1 = Coupon(title: "Apples Store", description: "10% discount on apples", cost: 30, acquired: false)
        let coupon2 = Coupon(title: "Book Store", description: "20% discount on books", cost: 50, acquired: true)
        self.allCoupons.append(coupon1)
        self.allCoupons.append(coupon2)
    }
}
