//
//  APICall.swift
//  application
//
//  Created by Tarful on 3/6/22.
//

import Foundation
import Alamofire


class ApiCall {
    func afGet() {
        AF.request("https://httpbin.org/get").response {
            response in debugPrint(response)
        }
    }
}

