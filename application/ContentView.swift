import SwiftUI
import Alamofire


struct ContentView: View {
    @State var showingNameView = false
    @State var showingCameraView = false
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("View A"), tag: "A", selection: $selection) { NameView() }
                NavigationLink(destination: Text("View B"), tag: "B", selection: $selection) { CameraView() }

                Button("Tap to show A") {
                    selection = "A"
                }

                Button("Tap to show B") {
                    selection = "B"
                }
            }
            .navigationTitle("Navigation")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
