//
//  APICall.swift
//  application
//
//  Created by Tarful on 3/6/22.
//

import Foundation
import Alamofire

let spreadsheet = "1koPnZYuqiP5Z00V0YSKMPa2cpvOsqh5iDaa6K-ROvYo"
class ApiCall {
    func afGet() {
        AF.request("https://sheets.googleapis.com/v4/spreadsheets/" + spreadsheet + "/values/1:1").response {
            response in debugPrint(response)
        }
    }
}

