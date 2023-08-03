import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var cameraController = CameraController()

    var body: some View {
        VStack {
            if cameraController.isTaken {
                Text("Photo Taken!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
            } else {
                CameraPreview2(camera: cameraController)
            }

//            Button(action: {
//                cameraController.capturePhoto()
//            }) {
//                Image(systemName: "camera.circle.fill")
//                    .font(.system(size: 80))
//                    .foregroundColor(.white)
//            }
//            .padding()
        }
        .onAppear {
            cameraController.checkIfCameraAuthorized()
        }
    }
}

struct CameraPreview2: UIViewRepresentable {
    @ObservedObject var camera: CameraController

    func makeUIView(context: Context) ->  UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.videoGravity = .resizeAspectFill
        camera.preview.frame = view.layer.bounds
        view.layer.addSublayer(camera.preview)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ProfileManager())
    }
}
