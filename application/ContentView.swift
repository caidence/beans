import SwiftUI
import Alamofire


struct ContentView: View {
    @State var showingNameView = false
    @State var showingCameraView = false
    
    var body: some View {
        VStack {
            Spacer()
            
            // Sign in text
            HStack {
<<<<<<< HEAD
                Text("Sign in")
                    .padding()
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()


            HStack {
                Spacer()
                
                // Input name button
=======
>>>>>>> QA
                Button("Input name") {
                    self.showingNameView.toggle()
                }
                .sheet(isPresented: $showingNameView) {
                    NameView()
                }
<<<<<<< HEAD
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 18 / 255, green: 18 / 255, blue: 18 / 255))
                .cornerRadius(8)
                
                
                // Open camera button
=======
                
>>>>>>> QA
                Button("Open camera") {
                    self.showingCameraView.toggle()
                }
                .sheet(isPresented: $showingCameraView) {
                    CameraView()
                }
<<<<<<< HEAD
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 18 / 255, green: 18 / 255, blue: 18 / 255))
                .cornerRadius(8)
                
                Spacer()
            }
            
            Spacer()
        }
        .background(Color(red: 75 / 255, green: 75 / 255, blue: 75 / 255))
    }
=======
            } // End HStack
        } // End VStack
    } //End Body
>>>>>>> QA
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
