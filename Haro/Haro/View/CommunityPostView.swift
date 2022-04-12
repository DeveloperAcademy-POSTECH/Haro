//
//  CommunityPostView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

struct Comment {
    let id: UUID = UUID()
    let userName: String
    let commentStr: String
    let time: Int
}

//extension Comment: Codable {}
extension Comment: Identifiable {}
//extension Comment: Equatable {}

struct CommunityPostView: View {
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    
    @State var likePost: Bool = false
    @State var likeNum: Int = 0
    @State var commentNum: Int = 5
    
    let commentSample = [
        Comment(userName: "유저1", commentStr: "유저1이 작성한 댓글내용입니다.유저1이 작성한 댓글내용입니다.유저1이 작성한 댓글내용입니다.", time: 1),
        Comment(userName: "유저2", commentStr: "유저2이 작성한 댓글내용입니다ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ", time: 2),
        Comment(userName: "유저3", commentStr: "유저3이 작성한 댓글내용입니다.", time: 3),
        Comment(userName: "유저4", commentStr: "유저4이 작성한 댓글내용입니다.", time: 4),
        Comment(userName: "유저5", commentStr: "유저5이 작성한 댓글내용입니다.", time: 5),
        Comment(userName: "유저6", commentStr: "유저6이 작성한 댓글내용입니다.", time: 6),
        Comment(userName: "유저7", commentStr: "유저7이 작성한 댓글내용입니다.", time: 7)
    
    ]
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    Void()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                Spacer()
                Button {
                    Void()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            
            ScrollView{
                HStack{
                    Image("back")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .cornerRadius(100)
                        .padding(.trailing, 5)
                    
                    Text("포항마스터")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                    
                    Spacer()
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 20)
                
                Divider()
                    .background(.gray)
                    .padding(.horizontal, 20)
                
                Text("게시판 내용 게시판 내용 게시판 내용 게시판 내용 게시판 내용 게시판 내용")
                    .font(.custom("", size: 15))
                    .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                Image("back")
                    .resizable()
                    .cornerRadius(12)
                    .frame(width: screenWidth - 40, height: screenHeight * 0.25)
                
                HStack{
                    Spacer()
                    Button {
                        likePost.toggle()
                        likePost ? (likeNum += 1) : (likeNum -= 1)
                    } label: {
                        Image(systemName: likePost ? "heart.fill" : "heart")
                            .font(.system(size: 13))
                            .foregroundColor(.red)
                            .padding(.trailing, -5)
                        Text(String(likeNum))
                            .font(.system(size: 13))
                            .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                    }
                    .padding(.trailing, 2)
                    
                    Image(systemName: "message.fill")
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 220/255, green: 220/255, blue: 225/255))
                        .padding(.trailing, -5)
                    Text(String(commentNum))
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))

                    
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                
                Divider()
                    .background(.gray)
                    .padding(.horizontal, 20)
                
                ForEach(commentSample) {
                    CommentView($0.userName, $0.commentStr, $0.time)
                }
            }
            
            HStack{
                TextField("댓글을 입력해주세요", text: .constant(""))
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20)
                
                Button {
                    Void()
                } label: {
                    Image(systemName: "paperplane")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 20)
            }
            .padding(.vertical)
        }
    }
}

struct CommentView: View {
    var time: Int
    var userName: String
    var commentStr: String
    
    init(_ userName: String = "NoName", _ commentStr: String = "댓글 내용입니다", _ time: Int = 0){
        self.userName = userName
        self.commentStr = commentStr
        self.time = time
    }
    
    var body: some View {
        HStack{
            VStack{
                Image("back")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .cornerRadius(100)
                    .padding(.leading, 20)
                Spacer()
            }
            
            VStack{
                HStack{
                    Text(userName)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                        .padding(.top, 5)
                        .padding(.bottom, 1)
                    
                    Text(String(time) + "분 전")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.leading, 1)
                        .padding(.top, 3)
                    
                    Spacer()
                }
                
                HStack{
                    Text(commentStr)
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                        .padding(.trailing, 20)
                    Spacer()
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 15)
                
        }
    }
}

struct CommunityPostView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityPostView()
        
    }
}
