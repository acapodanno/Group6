//
//  CouponStore.swift
//  Group6
//
//  Created by Ugo Barbato on 16/02/22.
//

import Foundation

class CouponStore: ObservableObject {
    @Published var allCoupons = [Coupon]()
    var couponApi:CouponApi = CouponApi()
    @Published var couponBuy = [Coupon]()
    init() {
        self.allCoupons = couponApi.getAllCoupon()
    }
    
    func updateAcquired (id: Int32) {
        if allCoupons.isEmpty {
            couponBuy = allCoupons.filter{$0.id == id}
        }
        else {
            couponBuy.append(contentsOf: allCoupons.filter{$0.id == id})
        }
    }
}
