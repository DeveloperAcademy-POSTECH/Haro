//
//  CommunityMeetingPostView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/12.
//

import SwiftUI

struct CommunityMeetingPostView: View {
    let entity: CommunityMeetingEntity
    
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
                
                HStack {
                    Text(entity.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("주말")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 11)
                        .padding(.vertical, 5)
                        .background(
                            Color(red: 196/255, green: 197/255, blue: 251/255)
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 7)
                        )
                }
                
                HStack {
                    Text(entity.descript)
                    Spacer()
                }
                .padding(.vertical)
                    
                Image(entity.photo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                
                HStack{
                    Text("🌞 \(entity.attendee)")
                        .font(.subheadline)
                    Spacer()
                }
                .padding(.vertical, 10)
                
                Divider()
            }
            
            HStack {
                Spacer()
                Button {
                    Void()
                } label: {
                    Text("참여하기")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .background(
                Capsule()
                    .foregroundColor(
                        Color(red: 234/255, green: 246/255, blue: 146/255)
                    )
            )
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

struct CommunityMeetingPostView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityMeetingPostView(
            entity:
                CommunityMeetingEntity(
                    writerName: "writerName",
                    writerPhoto: "Smile",
                    category: "category",
                    title: "논현동 철학 독서 모임",
                    descript: "주말마다 철학 책 읽는 독서모임입니다!\n논현동 주변 카페에서 모여요!",
                    photo: "photo",
                    attendee: "남구책방님 외 2명"
                )
        )
    }
}

