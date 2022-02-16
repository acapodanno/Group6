//
//  CouponDetailView.swift
//  Group6
//
//  Created by Ugo Barbato on 16/02/22.
//

import SwiftUI

struct CouponDetailView: View {
    @EnvironmentObject var couponS: CouponStore
    var coupon: Coupon
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("title")) {
                    Text("\(coupon.title)")
                }
                
                Section(header: Text("description")) {
                    Text("\(coupon.description)")
                }
                
                Section {
                    HStack {
                        Text("Points Needed")
                        Spacer()
                        Text("\(coupon.cost) points")
                    }
                }
                
                Section(footer: HStack {
                    Spacer()
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "cart.fill")
                                .font(.title)
                            Text("Redeem")
                                .font(.title)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                ) {
                    EmptyView()
                }
                
            }
            .navigationBarTitle("Coupon Details", displayMode: .inline)
        }
    }
}

struct CouponDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CouponDetailView(coupon: Coupon(title: "Apples Store", description: "This coupon is a 10% discount on apples", cost: 50))
            .previewInterfaceOrientation(.portrait)
    }
}

