//
//  beansApp.swift
//  beans
//
//  Created by Caiden Pyle on 4/3/22.
//

import SwiftUI
import Firebase

@main
struct beansApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
