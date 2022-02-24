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

    var request = URLRequest(url: URL(string: host+"/signup?username=\(username)&email=\(email)&password=\(password)")!,timeoutInterval: Double.infinity)
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
    
    func signin(email:String,password:String)-> User{
        
        var semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: host+"/signin?email=\(email)&password=\(password)")!,timeoutInterval: Double.infinity)
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
        return User(isOperator: false, userName: "Shark73", level: 2, points: 50, profileImage: nil, reportings: [])

    }

}
