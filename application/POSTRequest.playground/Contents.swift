import UIKit

let gfID = "234wer"
let fName = "Tom"
let lName = "Selleck"

let df = DateFormatter()
df.dateFormat = "yyyy-MM-dd hh:mm:ss"
let now = df.string(from: Date())

let POSTDict:[String:Any] = [
    "entry.314091477": fName,
    "entry.1671374062": lName,
    ]

let responseID = "1FAIpQLSc_mDdFryJCh-L0H6tnGF4utq6015QsPXZdXZd0pUBuXHYY3g"
let url = URL(string: "https://docs.google.com/forms/u/0/d/e/" + responseID + "/formResponse")!

let configuration = URLSessionConfiguration.default
configuration.timeoutIntervalForRequest = 60
configuration.timeoutIntervalForRequest = 60
let session = URLSession(configuration: configuration)

var request = URLRequest(url: url)
request.httpMethod  = "POST"
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
request.addValue("application/json", forHTTPHeaderField: "Accept")

do {
    request.httpBody = try JSONSerialization.data(withJSONObject: POSTDict, options: .prettyPrinted)
}
catch let error { print(error.localizedDescription)}

let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
    if error != nil || data == nil {
        print("client error")
        return
    }
    
    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        print("server error")
        return
    }
    
    guard let mime = response.mimeType, mime == "application/json" else {
        print("response is not json")
        return
    }
    
    do {
        let json = try JSONSerialization.jsonObject(with: data!, options: [])
        print("response is: ", json)
    }
    catch { print("JSON error: \(error.localizedDescription)")
    }
})

task.resume()

