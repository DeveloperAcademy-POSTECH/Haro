//
//  StoryWriteView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI
import AVFoundation

struct StoryWriteView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        CameraView(showModal: $showModal)
    }
}
 
struct CameraView: View {
    @ObservedObject var camera = CameraViewModel()
    @Binding var showModal: Bool
    
    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                HStack {
                    Button {
                        self.showModal.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
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
                    .opacity(camera.isTaken ? 1 : 0)
                }
                .padding([.leading, .trailing, .top])
                Spacer()
                HStack {
                    if camera.isTaken {
                        Button {
                            if !camera.isSaved {
                                camera.savePic()
                            }
                        } label: {
                            Image(systemName: camera.isSaved ? "square.and.arrow.down.fill" : "square.and.arrow.down" )
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(.gray)
                                .clipShape(Capsule())
                        }

                        Spacer()
                        
                        Button {
                            self.showModal.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "map")
                                    .foregroundColor(.white)
                                Text("업로드")
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(.gray)
                            .clipShape(Capsule())
                        }
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
                .padding([.leading, .trailing])
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
