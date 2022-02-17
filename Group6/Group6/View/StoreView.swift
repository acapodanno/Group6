//
//  StoreView.swift
//  Group6
//
//  Created by Ugo Barbato on 16/02/22.
//

import SwiftUI

struct StoreView: View {
    
    @State private var typeSelected = "Available Coupons"
    var types = ["Available Coupons", "My Coupons"]
    
    @StateObject var couponStore = CouponStore()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("What coupon do you need?", selection: $typeSelected) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                
                List {
                    ForEach(couponStore.allCoupons) {ccoupon in
                        if typeSelected == "Available Coupons" && !ccoupon.acquired || typeSelected == "My Coupons" && ccoupon.acquired {
                            NavigationLink(destination: {CouponDetailView(coupon: ccoupon)}) {
                                CouponCell(coupon: ccoupon)
                            }
                        }
                    }
                }
                .navigationTitle("Store")
            }
        }
    }
}

struct CouponCell: View {
    var coupon: Coupon
    
    var body: some View {
        HStack {
            Text(coupon.title)
            Spacer()
            Text("\(coupon.cost)")
        }
        .frame(height: 60.0)
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
