//
//  BackendConnector.swift
//  KnowItAll
//
//  Created by Jonathon Shen on 10/13/17.
//  Copyright © 2017 Jonathon Shen. All rights reserved.
//

import Foundation
import SwiftyJSON
//var host = "https://0a79ab09.ngrok.io/api"
//var host = "https://4f3fe20d.ngrok.io/api"
var host = "http://knowitalllive2.xxs9rzfmhq.us-west-1.elasticbeanstalk.com/api"

func getJSONFromURL(_ urlString: String, _ type: String) -> JSON {
    var url = host + urlString
    print(url)
    url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    var json = JSON.null
    var queryFinished = false

    let request = NSMutableURLRequest(url: URL(string: url)!)
    request.httpMethod = type
    
    let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
        if error != nil {
            return
        }
        json = try! JSON(data: data!)
        print(json)
        queryFinished = true
    }
    task.resume()
    // Blocks until a query is returned from http request
    while queryFinished == false {}
    return json
}

func postImageWithURL(urlString: String, httpBody: Data) -> JSON {
    var url = host + urlString
    print(url)
    url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let request = NSMutableURLRequest(url: URL(string: url)!)
    var json = JSON.null
    var queryFinished = false
    request.httpMethod = "POST"
    request.httpBody = httpBody
    let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
        if error != nil {
            return
        }
//        json = try! JSON(data: data!)
//        print(json)
        queryFinished = true
    }
    task.resume()
    // Blocks until a query is returned from http request
    while queryFinished == false {}
    return json
}
