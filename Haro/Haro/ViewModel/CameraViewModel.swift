//
//  CameraViewModel.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI
import AVFoundation

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    
    func check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: setUp()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUp()
                }
            }
        case .denied: self.alert.toggle()
        default : return
        }
    }
    
    func setUp() {
        do {
            self.session.beginConfiguration()
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video,  position: .back) else { return }
            let input = try AVCaptureDeviceInput(device: device)
            guard self.session.canAddInput(input) else { return }
            self.session.addInput(input)
            guard self.session.canAddOutput(self.output) else { return }
            self.session.sessionPreset = .photo
            self.session.addOutput(self.output)
            self.session.commitConfiguration()
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func takePic() {
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        withAnimation {
            self.isTaken = true
        }
    }
    
    func reTake() {
        self.session.startRunning()
        withAnimation {
            self.isTaken = false
            self.isSaved = false
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        self.session.stopRunning()
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard error == nil else { return }
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.picData = imageData
    }
    
    func savePic() {
        guard let image = UIImage(data: self.picData) else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.isSaved = true
    }
}
