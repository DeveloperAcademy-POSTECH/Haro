//
//  CommunityPostView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

struct CommunityPostView: View {
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    
    @State var likePost: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    Void()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
                Button {
                    Void()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding(.all, 30)
            
            HStack{
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 10)
                
                Text("포항마스터")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 350, height: 0.8)
                .padding(.vertical, 10)
            
            Text("게시판 내용 게시판 내용 게시판 내용 게시판 내용 게시판 내용 게시판 내용")
                .font(.custom("", size: 15))
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            
            Image("back")
                .resizable()
                .cornerRadius(20)
                .frame(width: 350, height: 215)
//                .frame(width: screenWidth * 0.9, height: screenHeight * 0.25)
            
            HStack{
                Spacer()
                Button {
                    likePost.toggle()
                } label: {
                    Image(systemName: likePost ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .padding(.trailing, -5)
                    Text("30")
                        .foregroundColor(.black)
                        .padding(.trailing, 10)
                }
                
                Image(systemName: "message.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, -5)
                Text("30")
                    .foregroundColor(.black)

                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 350, height: 0.8)
                .padding(.bottom, 10)
            
            Spacer()
            
        }
    }
}

struct CommunityPostView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityPostView()
    }
}
