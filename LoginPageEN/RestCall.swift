//
//  RestCall.swift
//  LoginPageEN
//
//  Created by TechReaderDongKey on 2020/08/15.
//  Copyright © 2020 TechReaderDongKey. All rights reserved.
//

import Foundation

func PostRequest(received_url : String, id : String , pswd : String) -> String{
    var session = URLSession.shared
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    configuration.timeoutIntervalForResource = 30
    session = URLSession(configuration: configuration)

    let url = URL(string: received_url)!

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    let parameters = ["userid": id, "password": pswd]

    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
    }

    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

        if error != nil || data == nil {
            print("Client error!")
            return
        }

        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            print("There is server error!")
            return
        }

        guard let mime = response.mimeType, mime == "application/json" else {
            print("response is not json")
            return
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            print("The Response is : ",json)
            return json as! String
        } catch {
            print("JSON error: \(error.localizedDescription)")
        }

    })

    task.resume()
}
