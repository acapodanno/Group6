//
//  CouponStore.swift
//  Group6
//
//  Created by Ugo Barbato on 16/02/22.
//

import Foundation

class CouponStore: ObservableObject {
    @Published var allCoupons = [Coupon]()
}
