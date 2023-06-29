//
//  ScanView.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-25.
//

import SwiftUI

struct ScanView: View {
    @StateObject var cameraController = CameraController()

    var body: some View {
        ZStack {
            CameraPreview(camera: cameraController)
                .ignoresSafeArea(.all, edges: .all)

            VStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Button(action: { cameraController.isTaken.toggle() }, label: {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 65, height: 65)

                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .frame(width: 75, height: 75)
                    }
                })

                Spacer()
            }
        }
        .onAppear {
            #if !targetEnvironment(simulator)
            cameraController.checkIfCameraAuthorized()
            #endif
        }
    }
}


struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}


