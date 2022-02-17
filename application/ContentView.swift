//
//  ContentView.swift
//  application
//
//  Created by Caiden Pyle on 2/16/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingNameView = false
    
    var body: some View {
        VStack {
            Text("Sign in")
                .padding()
            
            HStack {
                Text("Input name")
                    .padding()
                Text("Open camera")
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}