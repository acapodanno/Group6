//
//  UserApi.swift
//  Group6
//
//  Created by Alessandro Capodanno on 23/02/22.
//

import Foundation
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class UserApi{

    func signup(username:String,email:String,password:String){
    var semaphore = DispatchSemaphore (value: 0)

    var request = URLRequest(url: URL(string: "http://192.168.1.52:8081/signup?username=alex2&email=alessandro.capodanno95@gmail.com&password=123456")!,timeoutInterval: Double.infinity)
    request.httpMethod = "POST"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        semaphore.signal()
        return
      }
      print(String(data: data, encoding: .utf8)!)
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()
    }
    
    func signin(email:String,password:String){
        
        var semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "http://192.168.1.52:8081/signin?email=alessandro.capodanno95@gmail.com&password=123456")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

    }

}
