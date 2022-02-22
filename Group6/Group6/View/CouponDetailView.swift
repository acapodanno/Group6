//
//  CouponDetailView.swift
//  Group6
//
//  Created by Ugo Barbato on 16/02/22.
//

import SwiftUI

struct CouponDetailView: View {
    @State private var showingAlert = false
    @State private var couponAcquired = false
    @EnvironmentObject var couponS: CouponStore
    @StateObject var locationManager = LocationManager()
    var coupon: Coupon
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("title")) {
                        Text("\(coupon.title)")
                    }
                    
                    Section(header: Text("description")) {
                        Text("\(coupon.description)")
                    }
                    
                    Section(header: Text("condition")){
                        HStack {
                            Text("Points Needed")
                            Spacer()
                            Text("\(coupon.cost) points")
                        }
                    }
                    if !coupon.acquired {
                        Section (footer:
                                    HStack {
                            Spacer()
                            Button(action: {
                                showingAlert = true
                                couponAcquired = true
                                // TODO: AGGIUNGERE SALVATAGGIO DEL COUPON NELLA SEZIONE "MY COUPONS" CON MODELLO REST
                            }) {
                                HStack {
                                    Image(systemName: "cart.fill")
                                        .font(.body)
                                    Text("Redeem")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(couponAcquired == true)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Purchase completed"), message: Text("You can find it in My Coupons section"), dismissButton: .default(Text("OK")))
                                    }
                            Spacer()
                        }) {
                            EmptyView()
                        }
                    }
                    
                }
            }
            .navigationTitle("Coupon Details")
        }
    }
}


struct CouponDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CouponDetailView(coupon: Coupon(id:0,title: "", description: "", cost: 0, acquired: false))
            .previewInterfaceOrientation(.portrait)
    }
}

