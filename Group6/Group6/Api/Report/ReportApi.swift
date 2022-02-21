//
//  ReportApi.swift
//  Group6
//
//  Created by Alessandro Capodanno on 21/02/22.
//
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

var host = "http://192.168.1.52:8081"



func updateStatuSolvedReport(){
    let sem = DispatchSemaphore (value: 0)

    var req = URLRequest(url: URL(string: host+"/update-status-solved-report/1")!,timeoutInterval: Double.infinity)
    req.httpMethod = "PUT"
    let task = URLSession.shared.dataTask(with: req) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        sem.signal()
        return
      }
      print(String(data: data, encoding: .utf8)!)
      sem.signal()
    }

    task.resume()
    sem.wait()
}

func getAllReport(){
    let semaphore = DispatchSemaphore (value: 0)

    var request = URLRequest(url: URL(string: host+"/get-all-report")!,timeoutInterval: Double.infinity)
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
func updateStatuTakenReport(){
    let sem = DispatchSemaphore (value: 0)

    var req = URLRequest(url: URL(string: host+"/update-status-taken-report/1")!,timeoutInterval: Double.infinity)
    req.httpMethod = "PUT"
    let task = URLSession.shared.dataTask(with: req) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        sem.signal()
        return
      }
      print(String(data: data, encoding: .utf8)!)
      sem.signal()
    }

    task.resume()
    sem.wait()
}
func addReport(latitude:Double,longitude:Double,description:String){
    let semaphore = DispatchSemaphore (value: 0)

    let parameters = "{\r\n    \"latitude\":"+latitude+",\r\n    \"longitude\":"+longitude+",\r\n    \"description\":"+description+"\r\n}"
    let postData = parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: host+"/add-report")!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    request.httpMethod = "POST"
    request.httpBody = postData

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
