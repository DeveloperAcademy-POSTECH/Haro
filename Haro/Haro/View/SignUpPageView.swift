//
//  SignUpPageView.swift
//  Haro
//
//  Created by kelly on 2022/04/11.
//

import SwiftUI
import PhotosUI
import MapKit

struct SignUpPageView: View {
    @ObservedObject private var viewModel = SignUpPageViewModel()
    @State private var goNext = false
    @State var profileImage: [UIImage] = []
    @State var picker: Bool = false
    
    var body: some View {
        VStack (alignment: .center) {
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 90, height: 90)
                Button {
                    picker.toggle()
                } label: {
                    if !profileImage.isEmpty {
                        var img = profileImage[0]
                        Image(uiImage: img)
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(20)
                    } else {
                        Text ("프로필 사진")
                            .font(.caption)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(Color(red: 200/255, green: 200/255, blue: 200/255))
                                    .frame(width: 90, height: 90)
                                    
                            }
                    }
                }
                .sheet(isPresented: $picker) {
                    ImagePicker(images: $profileImage, picker: $picker)
                }
            }
            
            Spacer()
            
            HStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 30, height: 30)
                    Image(systemName: "person")
                        .font(.title2)
                }
                .padding(.trailing, 20)
                
                CustomTextField(placeHolder: "닉네임 (영문 + 숫자 5~20)", text: $viewModel.nickName)
                    .foregroundColor(viewModel.nickName.isEmpty || viewModel.isValidName ? Color.init(red: 255/255, green: 180/255, blue: 10/255) : .red)
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 10)
           
            HStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 30, height: 30)
                    Image(systemName: "envelope")
                        .font(.title2)
                }
                .padding(.trailing, 20)
                
                CustomTextField(placeHolder: "이메일", text: $viewModel.email)
                    .foregroundColor(viewModel.email.isEmpty ||  viewModel.isValidEmail ? Color.init(red: 255/255, green: 180/255, blue: 10/255) : .red)
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 10)
            
            HStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 30, height: 30)
                    Image(systemName: "lock")
                        .font(.title2)
                }
                .padding(.trailing, 20)
                
                CustomSecureField(placeHolder: "비밀번호", text: $viewModel.password)
                    .foregroundColor(viewModel.password.isEmpty ||  viewModel.isValidPassword ? Color.init(red: 255/255, green: 180/255, blue: 10/255) : .red)
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 10)
            
            HStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 30, height: 30)
                    Image(systemName: "lock.shield")
                        .font(.title2)
                }
                .padding(.trailing, 20)
                
                CustomSecureField(placeHolder: "비밀번호 확인", text: $viewModel.passwordConfirm)
                    .foregroundColor(viewModel.passwordConfirm.isEmpty ||  viewModel.isValidPasswordConfirm ? Color.init(red: 255/255, green: 180/255, blue: 10/255) : .red)
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 10)
            
            
            Button {
                if viewModel.isSignUpPossible {
                    UserDefaults.standard.set(true, forKey: "token")
                    UserDefaults.standard.set(viewModel.nickName, forKey: "nickname")
                    goNext = true
                    if !profileImage.isEmpty {
                        ImageFileManager.shared.saveImage(image: profileImage[0], name: "image")
                    }
                }
            } label: {

                Text("회원가입")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 180, height: 50)
                    .background(Color.init(red: 255/255, green: 180/255, blue: 10/255))
                    .opacity(viewModel.isSignUpPossible ? 1 : 0.5)
                    .cornerRadius(80)
                    .padding(.top, 50)
            }
            .fullScreenCover(isPresented: self.$goNext, content: MainView.init)

            Spacer()
        }
        
    }
}

struct ImagePicker : UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent1: self )
    }
    
    @Binding var images : [UIImage]
    @Binding var picker : Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent :ImagePicker
        
        init(parent1 : ImagePicker) {
            parent = parent1
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.picker.toggle()
            
            for img in results {
                if img.itemProvider.canLoadObject(ofClass: UIImage.self){
                    img.itemProvider.loadObject(ofClass: UIImage.self) { (image, err) in
                        guard let selectedImage = image else {
                            print("err ")
                            return
                        }
                        if !self.parent.images.isEmpty {
                            self.parent.images.remove(at: 0)
                        }
                        self.parent.images.append(selectedImage as! UIImage )
                    }
                } else {
                    print("cannot be loaded ")
                }
            }
        }
    }
}


struct SignUpPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPageView()
    }
}

struct CustomTextField: View {
    let placeHolder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeHolder, text: $text)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding()
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1)
            )
    }
}

struct CustomSecureField: View {
    let placeHolder: String
    @Binding var text: String
    
    var body: some View {
        SecureField(placeHolder, text: $text)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding()
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1)
            )
    }
}

class ImageFileManager {
    static let shared: ImageFileManager = ImageFileManager()

    func saveImage(image: UIImage, name: String) {
    guard let data: Data = image.jpegData(compressionQuality: 1) ?? image.pngData() else { return }
    if let directory: NSURL = try? FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false
        ) as NSURL {
            do {
                try data.write(to: directory.appendingPathComponent(name)!)
            } catch let error as NSError {
                print("Could not saveImage: \(error), \(error.userInfo)")
            }
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir: URL = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ) {
            let path: String = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path
            let image: UIImage? = UIImage(contentsOfFile: path)
            return image
        }
        return nil
    }
}
