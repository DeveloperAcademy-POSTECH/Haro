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
    @State private var showAlert: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                    
                    SecureField("비밀번호", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(.white)
                        .cornerRadius(60)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    
                    Button {
                        self.showAlert = true
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
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("로그인 실패"), message: Text("가입되지 않은 사용자입니다."), dismissButton: .cancel())
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


struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
