//
//  ContentView.swift
//  application
//
//  Created by Caiden Pyle on 2/16/22.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var showingNameView = false
    @State var showingCameraView = false
    
    var body: some View {
        VStack {
            Text("Sign in")
                .padding()
            
            HStack {
                Button("Input name") {
                    self.showingNameView.toggle()
                }
                .sheet(isPresented: $showingNameView) {
                    NameView()
                }
                
                Button("Open camera") {
                    self.showingCameraView.toggle()
                }
                .sheet(isPresented: $showingCameraView) {
                    CameraView()
                }
            } // End HStack
        } // End VStack
    } //End Body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
