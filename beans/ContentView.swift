//
//  ContentView.swift
//  beans
//
//  Created by Caiden Pyle on 4/3/22.
//

import SwiftUI
import Firebase
import CodeScanner


struct ContentView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var meeting: String = ""
    @State private var isShowingScanner = false
    
    func sendData() {
        let udid = UIDevice.current.identifierForVendor!.uuidString
        
        let db = Firestore.firestore()
        db.collection("testSignInSheet").addDocument(
            data: [udid:
                    ["first_name": firstName, "last_name": lastName]
                  ])
    }
    
    var body: some View {
        VStack {
            VStack {
                TextField("First Name: ", text: $firstName)
                    .padding()
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            }
            .padding()

            VStack {
                TextField("Last Name: ", text: $lastName)
                    .padding()
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            }
            .padding()
            
            VStack {
                TextField("Meeting: ", text: $meeting)
                    .padding()
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            }
            .padding()
            VStack {
                Button("Sign in", action: sendData)
                    .padding()
                    .background(Color(UIColor.systemIndigo))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            VStack{
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                    
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Tim\nNortenSafetyTraining", completion: handleScan)
                }
            }
        }
        .padding()
    }
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 3 else { return }
            
            firstName = details[0]
            lastName = details[1]
            meeting = details[2]
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
