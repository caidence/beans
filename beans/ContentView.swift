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
    @State private var courseTitle: String = ""
    @State private var badge: String = ""
    @State private var bureau: String = ""
    @State private var instructor: String = ""
    @State private var sponsorAgency: String = ""
    @State private var instructorAgency: String = ""
    @State private var coordinator: String = ""
    @State private var isShowingScanner = false
    @State private var error = ""
    @State private var isShowingError = false
    @State private var temp = "qweaasd"
    @State private var isScanError = false
    
    
    func sendData() {
        let udid = UIDevice.current.identifierForVendor!.uuidString
        let db = Firestore.firestore()
        let docRef = db.collection("Training").document(courseTitle)
        
        docRef.getDocument { (document, err) in
            if let document = document, document.exists {
                db.collection("Training").document(courseTitle).updateData([udid: ["first_name": firstName, "last_name": lastName, "badge_id": badge, "bureau": bureau, "instructor": instructor, "course_title": courseTitle, "sponsor_agency": sponsorAgency, "instructor_agency": instructorAgency, "coordinator": coordinator]])
                }
            else {
                db.collection("Training").document(courseTitle).setData([udid: ["first_name": firstName, "last_name": lastName, "badge_id": badge, "bureau": bureau, "instructor": instructor, "course_title": courseTitle, "sponsor_agency": sponsorAgency, "instructor_agency": instructorAgency, "coordinator": coordinator]])
                }
            }
    }
    
    var body: some View {
        VStack {
            VStack {Text("")
                    .padding()
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    .disableAutocorrection(true)
            }
            .padding()
            
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
                TextField("Badge ID: ", text: $badge)
                    .padding()
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            }
            .padding()
            
            VStack {
                TextField("Bureau ", text: $bureau)
                    .padding()
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            }
            .padding()
            
            VStack {
                Text(courseTitle)
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
                    .disabled(firstName.isEmpty || lastName.isEmpty || courseTitle.isEmpty)
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
                }
                
            }
        }
        .alert(isPresented: $isScanError) {
                        Alert(title: Text("QR Code Error"), dismissButton:
                                .default(Text("OK")))
                    }
        .padding()
    }
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 5 else { isScanError = true; return }
            courseTitle = details[0].components(separatedBy: ":") [1].trimmingCharacters(in: .whitespaces)
            instructor = details[1].components(separatedBy: ":") [1].trimmingCharacters(in: .whitespaces)
            instructorAgency = details[2].components(separatedBy: ":") [1].trimmingCharacters(in: .whitespaces)
            sponsorAgency = details[3].components(separatedBy: ":") [1].trimmingCharacters(in: .whitespaces)
            coordinator = details[4].components(separatedBy: ":") [1].trimmingCharacters(in: .whitespaces)
            isScanError = true
            
        case .failure(_):
            isScanError = true
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
