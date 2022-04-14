//
//  CommunityPostView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

struct CommunityPostView: View {
    let entity: CommunityEntity
    @State var showLike: Bool = false
    @State var input: String = ""
    @State var commentNow: [CommentEntity] = []
    
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    HStack{
                        Image(entity.writerPhoto)
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                        Text(entity.writerName)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                            .padding(.leading, 14)
                        Spacer()
                    }
                    
                    Divider()
                        .padding(.vertical, 11)
                    
                    HStack{
                        Text(entity.text)
                            .font(.subheadline)
                            .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    Image(entity.photo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                    
                    HStack{
                        Spacer()
                        Button {
                            showLike.toggle()
                        } label: {
                            Image(systemName: showLike ? "heart.fill" : "heart")
                                .font(.subheadline)
                                .foregroundColor(.red)
                                .padding(.trailing, -5)
                            Text(showLike ? "\(entity.like + 1)" : "\(entity.like)")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                        }
                        .padding(.trailing, 2)
                        
                        Image(systemName: "message.fill")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 215/255, green: 215/255, blue: 220/255))
                            .padding(.trailing, -5)
                        Text("\(entity.comment.count)")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                        
                    }
                    .padding(.vertical, 10)
                    
                    Divider()
                    
                    ForEach(0..<commentNow.count, id: \.self) {
                        CommentView(
                            commentNow[$0].writerPhoto,
                            commentNow[$0].writerName,
                            commentNow[$0].text,
                            commentNow[$0].time
                        )
                    }
                    
                    ForEach(0..<entity.comment.count, id: \.self) {
                        CommentView(
                            entity.comment[$0].writerPhoto,
                            entity.comment[$0].writerName,
                            entity.comment[$0].text,
                            entity.comment[$0].time
                        )
                    }
                    
                }
                .padding(.horizontal, 18)
            }
            
            HStack{
                TextField("댓글을 입력해주세요", text: $input)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .font(.callout)
                    .overlay(Capsule().stroke(.gray))
                Button {
                    self.commentNow.append(CommentEntity(writerName: UserDefaults.standard.string(forKey: "nickname")!, writerPhoto: "noProfile", text: self.input, time: "1분 전"))
                    input = ""
                } label: {
                    Image(systemName: "paperplane")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
    
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 18)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Image
                .init(systemName: "magnifyingglass")
                .scaledToFit()
                .frame(width: 25.5, height: 25.5)
                .padding(.trailing, 5)
        }
        .padding(.top, 10)
    }
}

struct CommentView: View {
    let userImage: String
    let userName: String
    let time: String
    let commentString: String
    
    init(_ userImage:String, _ userName: String, _ commentString: String, _ time: String){
        self.userImage = userImage
        self.userName = userName
        self.commentString = commentString
        self.time = time
    }
    
    var body: some View {
        HStack{
            VStack{
                Image(userImage)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                Spacer()
            }
            
            VStack{
                HStack{
                    Text(userName)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                    
                    Text(time)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading, 1)
                    Spacer()
                }
                .padding(.bottom, 1)
                
                HStack{
                    Text(commentString)
                        .font(.subheadline)
                        .foregroundColor(Color(red: 53/255, green: 60/255, blue: 73/255))
                    
                    Spacer()
                }
            }
            .padding(.vertical, 10)
        }
    }
}

struct CommunityPostView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityPostView(
            entity:
                CommunityEntity(
                    writerName: "writerName",
                    writerPhoto: "Smile",
                    category: "category",
                    text: "text",
                    photo: "cat02",
                    like: 1,
                    comment: [
                        CommentEntity(
                            writerName: "gani",
                            writerPhoto: "Gani",
                            text: "text",
                            time: "time"
                        ),
                        CommentEntity(
                            writerName: "rey",
                            writerPhoto: "Rey",
                            text: "text",
                            time: "time"
                        ),
                        CommentEntity(
                            writerName: "min",
                            writerPhoto: "Min",
                            text: "text",
                            time: "time"
                        )
                    ]
                )
        )
    }
}
