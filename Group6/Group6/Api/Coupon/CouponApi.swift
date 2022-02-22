//
//  CouponApi.swift
//  Group6
//
//  Created by Alessandro Capodanno on 22/02/22.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
class CouponApi{

    func getAllCoupon()-> [Coupon]{
    var coupons:[Coupon]=[]

    var semaphore = DispatchSemaphore (value: 0)

    var request = URLRequest(url: URL(string: "http://192.168.1.52:8081/get-all-coupon")!,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        semaphore.signal()
        return
      }
      print(String(data: data, encoding: .utf8)!)
        do{
          if  var json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],let  couponsResponse = json["message"] as? [[String: Any]]{
                        for coupon in couponsResponse {
                            let id = coupon["id"] as? Int32 ?? 00
                            let description = coupon["description"] as? String ?? ""
                            let title = coupon["title"] as? String ?? ""
                            let point = coupon["point"] as? Int ?? 0
                            coupons.append (Coupon(id:id,title: title,description: description,cost: point,acquired: false))
                            
                        }
                        print(coupons)
                    }
        }catch{
            print("Error!")
        }

      semaphore.signal()
    }

    task.resume()
    semaphore.wait()
        return coupons
    }
}
