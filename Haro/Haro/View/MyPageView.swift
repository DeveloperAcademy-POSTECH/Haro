//
//  MyPageView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

struct MyPageView: View {
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("마이페이지")
                .font(.system(size: 26))
                .foregroundColor(Color(red: 36/255, green: 36/255, blue: 36/255))
                .fontWeight(.heavy)
            
            HStack(alignment: .center, spacing: 16) {
                Image("back")
                    .resizable()
                    .cornerRadius(24)
                    .frame(width: 60, height: 60)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("포항마스터")
                        .font(.system(size: 16))
                    
                    HStack {
                        Image(systemName: "flag")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 149/255, green: 149/255, blue: 149/255))
                        
                        Text("운동중")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 149/255, green: 149/255, blue: 149/255))
                    }
                }
            }
            .padding(.vertical, 10)
            
            Divider()
                .foregroundColor(Color(red: 231/255, green: 231/255, blue: 231/255))
            
            Text("내가 쓴 글 전체보기")
                .font(.system(size: 16))
            
            Divider()
                .foregroundColor(Color(red: 231/255, green: 231/255, blue: 231/255))
            
            Text("설정")
                .font(.system(size: 16))
            
            Divider()
                .foregroundColor(Color(red: 231/255, green: 231/255, blue: 231/255))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
