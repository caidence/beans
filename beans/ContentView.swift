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
    @State private var event: String = ""
    @State private var isShowingScanner = false
    @State private var error = ""
    @State private var isShowingError = false
    @State private var isEditing = false
    @State private var isQRError = false
    
    func sendData() {
        let udid = UIDevice.current.identifierForVendor!.uuidString
        let db = Firestore.firestore()
        db.collection("Training").document(event.lowercased().replacingOccurrences(of: " ", with: "_")).updateData(
            [udid: ["first_name": firstName, "last_name": lastName]]){ err in
                if err != nil {
                    error = ("Error: Event does not exist")
                } else {
                    error = ("Attendance successfully submitted!")
                }
            }
        isShowingError = true
    }
    
    var body: some View {
        VStack {
            VStack {
                TextField("First Name: ", text: $firstName, onEditingChanged: { (v) in
                    isEditing = v
                })
                    .padding()
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    .disableAutocorrection(true)
            }
            .padding()

            VStack {
                TextField("Last Name: ", text: $lastName)
                    .padding()
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    .disableAutocorrection(true)
            }
            .padding()
            
            VStack {
                TextField("Event: ", text: $event)
                    .padding()
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    .disableAutocorrection(true)
            }
            .padding()
            VStack {
                Button("Sign in", action: sendData)
                    .padding()
                    .background(Color(UIColor.systemIndigo))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .disabled(firstName.isEmpty || lastName.isEmpty || event.isEmpty)
                    .alert(isPresented: $isShowingError) {
                                    Alert(title: Text(error), dismissButton:
                                            .default(Text("OK")))
                                }
            }
            .padding()
            VStack{
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], completion: handleScan)
                .alert(isPresented: $isShowingError) {
                                Alert(title: Text("Scan failed: QR code error"), dismissButton:
                                        .default(Text("OK")))
                            }
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
            guard details.count == 1 else { return }
            event = details[0]
        case .failure(let error):
            isQRError = true
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
