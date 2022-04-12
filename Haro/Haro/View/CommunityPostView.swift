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
    
    var body: some View {
        VStack{
            ScrollView{
                HStack{
                    Image(entity.writerPhoto)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    Text(entity.writerName)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.leading, 14)
                    Spacer()
                }
                
                Divider()
                    .padding(.vertical, 11)
                
                HStack{
                    Text(entity.text)
                    Spacer()
                }
                
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
                            .font(.callout)
                            .foregroundColor(.red)
                            .padding(.trailing, -5)
                        Text(showLike ? "\(entity.like + 1)" : "\(entity.like)")
                            .font(.callout)
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 2)
                    
                    Image(systemName: "message.fill")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding(.trailing, -5)
                    Text("\(entity.comment.count)")
                        .font(.callout)
                        .foregroundColor(.black)
                }
                .padding(.vertical, 10)
                
                Divider()
                
                ForEach(0..<entity.comment.count, id: \.self) {
                    CommentView(
                        entity.comment[$0].writerPhoto,
                        entity.comment[$0].writerName,
                        entity.comment[$0].text,
                        entity.comment[$0].time
                    )
                }
            }
            
            HStack{
                TextField("댓글을 입력해주세요", text: .constant(""))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .font(.callout)
                    .overlay(Capsule().stroke(.gray))
                Button {
                    Void()
                } label: {
                    Image(systemName: "paperplane")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
    
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Image
                .init(systemName: "magnifyingglass")
                .scaledToFit()
                .frame(width: 25.5, height: 25.5)
                .padding(.trailing, 5)
        }
        .padding(.horizontal)
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
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text(time)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading, 1)
                    Spacer()
                }
                .padding(.bottom, 1)
                
                HStack{
                    Text(commentString)
                        .font(.body)
                        .foregroundColor(.black)
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
