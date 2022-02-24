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

class ReportApi{
    



    func updateStatuSolvedReport(id: Int32){
    let sem = DispatchSemaphore (value: 0)

    var req = URLRequest(url: URL(string: host+"/update-status-solved-report/\(id)")!,timeoutInterval: Double.infinity)
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

func getAllReport() -> [ReportModel]{
    var reportsModel:[ReportModel]=[]
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
        do{
          if  var json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],let  reports = json["message"] as? [[String: Any]]{
                        for report in reports {
                            let id = report["id"] as? Int32 ?? 00
                            let description = report["description"] as? String ?? ""
                            var latitude:Double = 0
                            var longitude:Double = 0
                            var address:String = ""
                            if let position = report["position"] as? [String:Any]{
                                latitude = position["lat"] as? Double ?? 0
                                longitude = position["longitude"] as? Double ?? 0
                                address = position["address"] as? String ?? ""
                            }
                            var statusName:String = ""
                            if let status = report["status"] as? [String:Any]{
                                statusName = status["name"] as? String ?? ""
                            }
                            let createdAt = report["createdAt"] as? String ?? "1970-01-01 00:00:00"
                            let dateFormatter = DateFormatter()
                            

                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date = dateFormatter.date(from:createdAt)!
                            reportsModel.append (ReportModel(id:id,description: description,status: statusName,latitude: latitude,longitude: longitude,createdAt: date,address: address))
                            
                        }
                    }
        }catch{
            print("Error!")
        }

      semaphore.signal()
    }

    task.resume()
    semaphore.wait()
    return reportsModel

}
    func updateStatuTakenReport(id: Int32){
    let sem = DispatchSemaphore (value: 0)

    var req = URLRequest(url: URL(string: host+"/update-status-taken-report/\(id)")!,timeoutInterval: Double.infinity)
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
    func addReport(latitude:Double,longitude:Double,description:String,address:String){
    let semaphore = DispatchSemaphore (value: 0)
    let json: [String: Any] = ["latitude": "\(latitude)",
                               "longitude": "\(longitude)",
                               "description": "\(description)",
                               "address": "\(address)"
                                ]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    var parameters = "{\r\n\"latitude\":\"\(latitude)\""
    parameters += ",\r\n\"longitude\":\"\(longitude)\""
    parameters += ",\r\n\"description\":\"\(description)\""
    parameters += ",\r\n\"address\":\"\(address)\"\r\n}"
        print(parameters)
    
    let postData = parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: host+"/add-report")!,timeoutInterval: Double.infinity)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    request.httpMethod = "POST"
    request.httpBody = jsonData

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
