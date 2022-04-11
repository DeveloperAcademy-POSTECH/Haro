//
//  SignUpPageView.swift
//  Haro
//
//  Created by kelly on 2022/04/11.
//

import SwiftUI

struct SignUpPageView: View {
    @ObservedObject private var viewModel = SignUpPageViewModel()
    @State private var goNext = false
    
    var body: some View {
        NavigationView{
            VStack{
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
                
                Spacer()
                
                Button {
                    if viewModel.isSignUpPossible {
                        UserDefaults.standard.set(true, forKey: "token")
                        goNext = true
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
                        .padding(.top, 10)
                }
                .fullScreenCover(isPresented: self.$goNext, content: MainView.init)

                Spacer()
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

