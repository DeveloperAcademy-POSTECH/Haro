//
//  MyPageView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

struct MyPageView: View {
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    let image = ImageFileManager.shared.getSavedImage(named: "image")!
    @ObservedObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("마이페이지")
                .font(.title)
                .foregroundColor(Color(red: 36/255, green: 36/255, blue: 36/255))
                .fontWeight(.heavy)
            
            HStack(alignment: .center, spacing: 16) {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(24)
                    .frame(width: 60, height: 60)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(nickname)
                        .font(.title3)
                    
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.callout)
                            .foregroundColor(Color(red: 149/255, green: 149/255, blue: 149/255))
                        
                        Text(locationViewModel.region)
                            .font(.callout)
                            .foregroundColor(Color(red: 149/255, green: 149/255, blue: 149/255))
                    }
                }
            }
            .padding(.vertical, 10)
            
            Divider()
                .foregroundColor(Color(red: 231/255, green: 231/255, blue: 231/255))
            
            Text("내가 쓴 글 전체보기")
                .font(.body)
            
            Divider()
                .foregroundColor(Color(red: 231/255, green: 231/255, blue: 231/255))
            
            Text("설정")
                .font(.body)
            
            Divider()
                .foregroundColor(Color(red: 231/255, green: 231/255, blue: 231/255))
            
            Button {
                UserDefaults.standard.setValue(false, forKey: "token")
                exit(0)
            } label: {
                Text("회원 탈퇴")
                    .font(.body)
                    .foregroundColor(.black)
            }

            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
    }
}
