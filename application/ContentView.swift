import SwiftUI


struct ContentView: View {
    @State var showingNameView = false
    @State var showingCameraView = false
    
    var body: some View {
        VStack {
            Spacer()
            
            // Sign in text
            HStack {
                Text("Sign in")
                    .padding()
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()


            HStack {
                Spacer()
                
                // Input name button
                Button("Input name") {
                    self.showingNameView.toggle()
                }
                .sheet(isPresented: $showingNameView) {
                    NameView()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 18 / 255, green: 18 / 255, blue: 18 / 255))
                .cornerRadius(8)
                
                
                // Open camera button
                Button("Open camera") {
                    self.showingCameraView.toggle()
                }
                .sheet(isPresented: $showingCameraView) {
                    CameraView()
                }
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
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
