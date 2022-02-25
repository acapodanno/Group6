//
//  CouponDetailView.swift
//  Group6
//
//  Created by Ugo Barbato on 16/02/22.
//

import SwiftUI

struct CouponDetailView: View {
    @State private var showingAlert = false
    @State private var alertReason = ""
    @State private var couponAcquired = false
    @EnvironmentObject var couponS: CouponStore
    @StateObject var locationManager = LocationManager()
    var coupon: Coupon
    
    var user = UserApi().getUserById(id: UserDefaults.standard.integer(forKey: "userId"))
    
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
                                if user.points >= coupon.cost {
                                    showingAlert = true
                                    alertReason = "acquired"
                                    couponAcquired = true
                                    // TODO: AGGIUNGERE SALVATAGGIO DEL COUPON NELLA SEZIONE "MY COUPONS" CON MODELLO REST
                                    couponS.updateAcquired(id: coupon.id)
                                }
                                else {
                                    showingAlert = true
                                    alertReason = "error"
                                }
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
                                if alertReason == "error" {
                                    return Alert(title: Text("Error"), message: Text("You haven't got enough points to redeem this coupon"), dismissButton: .default(Text("Ok")))
                                }
                                else {
                                    return Alert(title: Text("Purchase completed"), message: Text("You can find it in My Coupons section"), dismissButton: .default(Text("OK")))
                                }
                            }
                        }) {
                            EmptyView()
                        }
                        
                    }
                }
                .navigationTitle("Coupon Details")
            }
        }
    }
    
}

struct CouponDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CouponDetailView(coupon: Coupon(id:0,title: "", description: "", cost: 0, acquired: false))
            .previewInterfaceOrientation(.portrait)
    }
}
    
