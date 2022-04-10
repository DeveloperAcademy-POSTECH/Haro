//
//  LoginPageView.swift
//  Haro
//
//  Created by kelly on 2022/04/10.
//

import SwiftUI

struct LoginPageView: View {
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    
    @State var email = ""
    @State var pwd = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                Spacer()
                    .background(Color.init(red: 234/255, green: 246/255, blue: 146/255))
                    .ignoresSafeArea()
                
                VStack{
                    Text("Haro")
                        .font(.system(size: 70))
                        .fontWeight(.heavy)
                        .shadow(color: .gray, radius: 40, x: 10, y: 10)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    TextField("이메일", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(.white)
                        .cornerRadius(60)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    
                    SecureField("비밀번호", text: $pwd)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(.white)
                        .cornerRadius(60)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    
                    Button {
                        guard !email.isEmpty, !pwd.isEmpty else {
                            return
                        }
                        print("login")
                    } label: {
                        Text("로그인")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 180, height: 50)
                            .background(Color.init(red: 255/255, green: 180/255, blue: 10/255))
                            .cornerRadius(80)
                            .padding(.top, 30)
                    }
                    
                    NavigationLink {
                        SignUpPageView()
                    } label: {
                        Text("회원가입")
                            .font(.headline)
                            .foregroundColor(Color.init(red: 255/255, green: 180/255, blue: 10/255))
                            .padding()
                            .frame(width: 200, height: 50)
                            .cornerRadius(80)
                            .padding(.top, 10)
                    }

                    Spacer()
                }
            }
        }
    }
}

struct SignUpPageView: View {
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    
    @State var name = ""
    @State var email = ""
    @State var pwd = ""
    @State var pwdConfirm = ""
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Image(systemName: "person")
                        .font(.title2)
                        .padding(.trailing, 20)
                    
                    TextField("이름", text: $name)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color.init(red: 255/255, green: 180/255, blue: 10/255))
                        )
                }
                .padding(.horizontal, 35)
                .padding(.vertical, 10)
               
                HStack{
                    Image(systemName: "envelope")
                        .font(.title2)
                        .padding(.trailing, 20)
                    
                    TextField("이메일", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color.init(red: 255/255, green: 180/255, blue: 10/255))
                        )
                }
                .padding(.horizontal, 35)
                .padding(.vertical, 10)
                
                HStack{
                    Image(systemName: "lock")
                        .font(.title2)
                        .padding(.trailing, 20)
                    
                    SecureField("비밀번호", text: $pwd)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color.init(red: 255/255, green: 180/255, blue: 10/255))
                        )
                }
                .padding(.horizontal, 35)
                .padding(.vertical, 10)
                
                HStack{
                    Image(systemName: "lock.shield")
                        .font(.title2)
                        .padding(.trailing, 20)
                    
                    SecureField("비밀번호 확인", text: $pwdConfirm)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color.init(red: 255/255, green: 180/255, blue: 10/255))
                        )
                }
                .padding(.horizontal, 35)
                .padding(.vertical, 10)
                
                Spacer()
                
                Button {
                    guard !email.isEmpty, !pwd.isEmpty else {
                        return
                    }
                    print("login")
                } label: {
                    Text("회원가입")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 180, height: 50)
                        .background(Color.init(red: 255/255, green: 180/255, blue: 10/255))
                        .cornerRadius(80)
                        .padding(.top, 20)
                }

                Spacer()
            }
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
