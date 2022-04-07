//
//  StoryWriteView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI
import AVFoundation

struct StoryWriteView: View {
    var body: some View {
        CameraView()
    }
}
 
struct CameraView: View {
    @ObservedObject var camera = CameraViewModel()
    
    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                if camera.isTaken {
                    HStack{
                        Spacer()
                        Button {
                            camera.reTake()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing)
                    }
                }
                Spacer()
                HStack {
                    if camera.isTaken {
                        Button {
                            if !camera.isSaved {
                                camera.savePic()
                            }
                        } label: {
                            Text(camera.isSaved ? "Saved" : "Save" )
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(.white)
                                .clipShape(Capsule())
                        }
                        .padding(.leading)

                        Spacer()
                    } else {
                        Button {
                            camera.takePic()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        }
                    }
                }
                .frame(height: 75)
            }
        }
        .onAppear {
            camera.check()
        }
    }
    
    struct CameraPreview: UIViewRepresentable {
        @ObservedObject var camera: CameraViewModel
        
        func makeUIView(context: Context) -> UIView {
            let view = UIView(frame: UIScreen.main.bounds)
            
            camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
            camera.preview.frame = view.frame
            camera.preview.videoGravity = .resizeAspectFill
            view.layer.addSublayer(camera.preview)
            
            camera.session.startRunning()
            
            return view
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
    }
}
