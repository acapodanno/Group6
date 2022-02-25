//
//  StoreView.swift
//  Group6
//
//  Created by Ugo Barbato on 16/02/22.
//

import SwiftUI

struct StoreView: View {
    @EnvironmentObject var couponStore:CouponStore

    @State private var typeSelected = "Available Coupons"
    var types = ["Available Coupons", "My Coupons"]
    
    
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
                    if typeSelected == "Available Coupons" {
                    ForEach(couponStore.allCoupons) {ccoupon in
                      
                            NavigationLink(destination: {CouponDetailView(coupon: ccoupon)}) {
                                CouponCell(coupon: ccoupon)
                            }.environmentObject(couponStore)
                        }
                    }else{
                        ForEach(couponStore.couponBuy) {ccoupon in
                                NavigationLink(destination: {CouponDetailView(coupon: ccoupon)}) {
                                    CouponCell(coupon: ccoupon)
                                }.environmentObject(couponStore)
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
