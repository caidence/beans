//
//  ContentView.swift
//  beans
//
//  Created by Caiden Pyle on 4/3/22.
//

import SwiftUI
import Firebase


struct ContentView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    
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
                Button("Sign in", action: sendData)
                    .padding()
                    .background(Color(UIColor.systemIndigo))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
