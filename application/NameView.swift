//
//  NameView.swift
//  application
//
//  Created by Caiden Pyle on 2/16/22.
//

import SwiftUI

struct NameView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var sheetId: String = ""
    
    var body: some View {
        VStack {
            TextField(
                "First name:",
                text: $firstName
            )
                .padding(33)
            
            TextField(
                "Last name:",
                text: $lastName
            )
                .padding(33)
            
            TextField(
                "Sheet ID:",
                text: $sheetId
            )
                .padding(33)
            
            Spacer()
            
            let getRequest = ApiCall()
            Button(action: {getRequest.afGet()
            }, label: {
                Text("Submit")
            })
        } // End VStack
    } // End Body
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
