//
//  FileApi.swift
//  Group6
//
//  Created by Alessandro Capodanno on 21/02/22.
//
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif



func addFile(fileUri:String){
    let semaphore = DispatchSemaphore (value: 0)

    let parameters = [
      [
        "key": "file",
        "src": fileUri,
        "type": "file"
      ]] as [[String : Any]]

    let boundary = "Boundary-\(UUID().uuidString)"
    var body = ""
    var error: Error? = nil
    for param in parameters {
      if param["disabled"] == nil {
        let paramName = param["key"]!
        body += "--\(boundary)\r\n"
        body += "Content-Disposition:form-data; name=\"\(paramName)\""
        if param["contentType"] != nil {
          body += "\r\nContent-Type: \(param["contentType"] as! String)"
        }
        let paramType = param["type"] as! String
        if paramType == "text" {
          let paramValue = param["value"] as! String
          body += "\r\n\r\n\(paramValue)\r\n"
        } else {
          let paramSrc = param["src"] as! String
          let fileData = try NSData(contentsOfFile:paramSrc, options:[]) as Data
          let fileContent = String(data: fileData, encoding: .utf8)!
          body += "; filename=\"\(paramSrc)\"\r\n"
            + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
        }
      }
    }
    body += "--\(boundary)--\r\n";
    let postData = body.data(using: .utf8)

    var request = URLRequest(url: URL(string: host+"/upload?file")!,timeoutInterval: Double.infinity)
    request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

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

func getAllFiles(){
    let semaphore = DispatchSemaphore (value: 0)
     
    var request = URLRequest(url: URL(string: host+"/files")!,timeoutInterval: Double.infinity)
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
